/**
*	Decode the opcode to select the appropriate data sources for the ALU
*	
**/

module data_sources(
	// GROUPX.STX.SOURCEX
	// General group
	// 11x00 : Ra,Rb   | 11x01 : Ra,U4      | 11x10 : RA,U8L     | 11x11 : RA, U8H
	// Load group
	// 01000 : Ra,(Rb) | 01001 : RA,(FP+U8) | 01010 : RA,(SP+U8) | 01011 : RA,(RS+U8)
	// Store group
	// 01100 : (Ra),Rb | 01101 : (FP+U8),RA | 01110 : (SP+U8),RA | 01111 : (RS+U8),RA
	// Jump group
	// 10x00 : PC,Rb   | 10x01 : PC,U8H.RBL | 10x10 : PC,PC+Rb   | 10x11 : PC,PC+U8H.RBL
	// Nop
	// 00xxx 
	input [1:0] SOURCEX, // Bits [9:8]
	input [1:0] GROUPX,  // Bits [15:14]
	input STX,            // Bit [11] - valid when group=01 (LD/ST)
	
	input [3:0] PHASEX, // {COMMIT,EXECUTE,DECODE,FETCH}
	
	input [15:0] REG_A, // from the register file
	input [15:0] REG_B, // from the register file
	input [15:0] REG_PC,// from the register file
	
	output reg [3:0] ADDR_A, // To the register file
	output reg [3:0] ADDR_B, // To the register file
	
	input [3:0] ARG_AX, // From the instruction LSB
	input [3:0] ARG_BX, // From the instruction LSB
	
	output reg[15:0] ALU_A, // To the ALU	
	output reg[15:0] ALU_B,  // To the ALU	
	
	output tri[15:0] RBUS,  // To the register bus	
	output tri[15:0] DBUS,  // To the data bus	
	output tri[15:0] ABUS,  // To the address bus	
	
	output reg AOUTENX, // Enable the address pins
	output reg DOUTENX, // Drive the data bus pins
	output reg DINENX,  // Drive the internal DBUS from the data pins
	
	output reg REGAOPX, // Load-enable to the register file
	output reg REGBOPX  // Inc/dec control

);

reg [15:0] RBUS_D;
reg [15:0] DBUS_D;
reg [15:0] ABUS_D;

reg RBUS_EN;
reg DBUS_EN;
reg ABUS_EN;



always @ (*)
begin
	ADDR_A = 4'b0000;	
	ADDR_B = 4'b0000;	
	ALU_A = 16'h0000;
	ALU_B = 16'h0000;
	AOUTENX = 0;
	DOUTENX = 0;
	DINENX = 0;
	REGAOPX = 0;
	REGBOPX = 0;
	RBUS_EN = 0;
	DBUS_EN = 0;
	ABUS_EN = 0;
	
	case (GROUPX[1:0])
		2'b00: // System
		begin
			// NOP for now
		end
		
		2'b10: // Jumps
		begin
			// NOP for now
		end
		
		2'b01: // Load/store
		begin
			case ({STX,SOURCEX[1:0]})
				3'b000: // LD Ra,(Rb)
				begin
					ADDR_A = ARG_AX;
					ADDR_B = ARG_BX;
					// No ALU operation
					// Enable loading Ra
					REGAOPX = 1;
					// Rb drives the address bus
					RBUS_EN = 0;
					ABUS_EN = 1;
					ABUS_D = REG_B;

				end

				3'b001: 
				begin
				end

				3'b010: 
				begin 
				end

				3'b011: 
				begin
				end

			endcase
		end
		
		2'b11: // Arithmetic/logical
		begin		
			case (SOURCEX[1:0])
				2'b00: 
				begin 
				end

				2'b01: 
				begin
				end

				2'b10: 
				begin 
				end

				2'b11: 
				begin
				end
 
			endcase
		end
	endcase
end

assign RBUS = ~RBUS_EN ? 16'bzzzzzzzzzzzzzzzz : RBUS_D;
assign DBUS = ~DBUS_EN ? 16'bzzzzzzzzzzzzzzzz : DBUS_D;
assign ABUS = ~ABUS_EN ? 16'bzzzzzzzzzzzzzzzz : ABUS_D;

endmodule