/**
* Instruction formats
* 
*  F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
*  0  0  ----------  X  X  ----------  ----------  Group 0: System
*  GPX      OPX               ARGA        ARGB
*              
*              
*  0  1  ----  ----  ----  ----------  ----------  Group 1: Load/Store
*  GPX   INCX  OPX   ARGX     ARGA        ARGB
*
*
*  1  0  ----  ----  ----  ----------  ----------  Group 2: Jumps
*  GPX   SKIPX OPX   CCX      ARGA        ARGB
*
*
*  1  1  ----------  ----  ----------  ----------  Group 3: General
*  GPX      OPX      ARGX     ARGA        ARGB
*              
* 
*/



module instruction_decode(
	
	input [15:0] DIN,
	input RESETN,
	input CLK,
	input CCZ,
	input CCC,
	input CCV,
	input CCP,
	
	output reg FETCH,
	output reg DECODE,
	output reg EXECUTE,
	output reg COMMIT,
	
	output reg [1:0] GPX,
	output reg [3:0] OPX,
	output reg [1:0] INCX,
	output reg [1:0] CCX,
	output reg [1:0] SKIPX,
	output reg [1:0] ARGX,
	output reg [3:0] ARGA,
	output reg [3:0] ARGB,

	output reg [1:0] BUSX,
	output reg [1:0] DINX,
	output reg [1:0] DOUTX,
	output reg [1:0] ADDRX,
	output reg [3:0] ALUX,
	output reg [1:0] SOURCEX,
	
	output reg WRITEX

);

localparam A_BUS_Z = 0;
localparam A_BUS_OUT = 1;
localparam A_BUS_IN = 2;


// Internal state
reg [1:0] PHI;
reg [15:0] DINR;
reg DO_JUMP;

// Decode the instruction group
assign	GPX = DINR[15:14];

always @ (*)
begin

	case (GPX[1:0])
		2'b00: begin // System
			INCX = 0;
			SKIPX = 0;
			CCX = 0;
			ARGX = 0;
			OPX = DINR[13:11];
		end
		
		2'b01: begin // Load/Store
			INCX = DINR[13:12];
			SKIPX = 0;
			CCX = 0;
			ARGX = DINR[9:8];
			OPX = DINR[11:10];
		end

		2'b10: begin // Jumps
			INCX = 0;
			SKIPX = DINR[13:12];
			CCX = DINR[9:8];
			ARGX = 0;
			OPX = DINR[11:10];
			DO_JUMP = 1;
			if(SKIPX[1])
			begin
				case (CCX)
					2'b00: begin // On Carry
						DO_JUMP = SKIPX[0] ? CCC : ~CCC;
					end

					2'b01: begin // On Zero
						DO_JUMP = SKIPX[0] ? CCZ : ~CCZ;
					end

					2'b10: begin // On Parity
						DO_JUMP = SKIPX[0] ? CCP : ~CCP;
					end

					2'b11: begin // On Negative
						DO_JUMP = SKIPX[0] ? CCV : ~CCV;
					end
				endcase
			end
			// Decode the target address
			if(DO_JUMP)
			begin
				case (OPX)
					2'b00: begin // JP Rb
						ALUX = 4'b0000;  // Use the MOV instruction to make the ALU copy ARG_B to the output
						SOURCEX = 2'b00; // Ra,Rb
						// We should force Ra to be 15 to point to the PC, but I'm going to 
						// rely on the assembler to do that
						// This means we have some "undocumented" conditional moves to all other registers :-)
					end
				endcase
			end
		end
			
		2'b11: begin // General
			INCX = 0;
			SKIPX = 0;
			CCX = 0;
			ARGX = DINR[9:8];
			OPX = DINR[13:10];
			ALUX = DINR[13:10];
			// Drive the data_sources
			SOURCEX = ARGX;
		end
	endcase

end

always @ (posedge RESETN)
begin
	PHI = 0;
end

always @ (posedge CLK)
begin
	ADDRX = A_BUS_Z;
	WRITEX = 1;
	
	case (PHI)
		0: begin
			FETCH = 1;
			DECODE = 0;
			EXECUTE = 0;
			COMMIT = 0;
			PHI <= 1;
			ADDRX <= A_BUS_OUT;
			end

		1: begin
			FETCH = 0;
			DECODE = 1;
			EXECUTE = 0;
			COMMIT = 0;
			// latch the instruction
			DINR = DIN;
			// copy through the args
			ARGA = DIN[7:4];
			ARGB = DIN[3:0];		
			PHI <= 2;
		end

		2: begin
			FETCH = 0;
			DECODE = 0;
			EXECUTE = 1;
			COMMIT = 0;
			PHI <= 3;
		end

		3: begin
			FETCH = 0;
			DECODE = 0;
			EXECUTE = 0;
			COMMIT = 1;
			PHI <= 0;
			WRITEX = 0;
		end

	endcase
end
endmodule