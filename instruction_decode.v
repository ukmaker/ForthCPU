/**
* Instruction formats
* 
*  F  E  D  C  B  A  9  8  7  6  5  4  3  2  1  0
*  0  0  ----------  X  X  ----------  ----------  Group 0: System
*  GPF      SYSF              ARGA        ARGB
*              
*              
*  0  1  ----  ----  ----  ----------  ----------  Group 1: Load/Store
*  GPF   INCF  LDSF  MODEF    ARGA        ARGB
*
*
*  1  0  ----  ----  ----  ----------  ----------  Group 2: Jumps
*  GPF   SKIPF JPF   CCF      ARGA        ARGB
*
*
*  1  1  ----------  ----  ----------  ----------  Group 3: General
*  GPF      ALUF     ARGF     ARGA        ARGB
*              
*  GPF   - Instruction group field
*  SYSF  - System operation field
*  INCF  - Increment/decrement field
*  LDSF  - Load/store operation field
*  MODEF - Addressing mode field
*  SKIPF - Condition handling field
*  CCF   - Condition code select field
*  JPF   - Jump type field
*  ALUF  - ALU operation field
*  ARGF  - ALU argument type field
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
	
	/**
	* Outputs for debugging
	**/
	output reg [1:0] GPF,   // Instruction group field
	output reg [3:0] SYSF,  // System operation field
	output reg [1:0] INCF,  // Increment/decrement field
	output reg [1:0] LDSF,  // Load/store operation field
	output reg [1:0] MODEF, // Addressing mode field
	output reg [1:0] SKIPF, // Condition handling field
	output reg [1:0] CCF,   // Condition code select field
	output reg [1:0] JPF,   // Jump type field
	output reg [3:0] ALUF,  // ALU operation field
	output reg [1:0] ARGF,  // ALU argument type field
	
	/**
	* Real outputs to control functional blocks
	**/
	output reg [1:0] REGX,        // Register operation
	output reg [3:0] ARGA,        // Register address A
	output reg [3:0] ARGB,        // Register address B
	output reg [3:0] REG_SOURCEX, // Data source for register file
	output reg [3:0] ALU_SOURCEX, // Data sources for ALU
	output reg [1:0] ALUX,        // ALU operation
	output reg [1:0] ADDRX,       // Address bus control
	output reg [1:0] DATAX,       // Data bus control
	
	output reg WRITEX,             // Write to memory
	output reg READX               // Read from memory

);

localparam A_BUS_Z = 0;
localparam A_BUS_OUT = 1;
localparam A_BUS_IN = 2;


// Internal state
reg [1:0] PHI;
reg [15:0] DINR;
reg DO_JUMP;


/**
* Internal decoding
**/
always @ (*)
begin
	GPF = DINR[15:14];
	// Set fields to zero by default
	SYSF = 0;
	INCF = 0;
	LDSF = 0;
	MODEF = 0;
	SKIPF = 0;
	CCF = 0;
	JPF = 0;
	ALUF = 0;
	ARGF = 0;
	
	case (GPF[1:0])
		2'b00: begin // System instruction
			SYSF = DINR[13:11];
		end
		
		2'b01: begin // Load/Store
			INCF = DINR[13:12];
			LDSF = DINR[11:10];
			MODEF = DINR[9:8];
		end

		2'b10: begin // Jumps
			SKIPF = DINR[13:12];
			JPF   = DINR[11:10];
			CCF   = DINR[9:8];

			DO_JUMP = 1;
			if(SKIPF[1])
			begin
				case (CCF)
					2'b00: begin // On Carry
						DO_JUMP = SKIPF[0] ? CCC : ~CCC;
					end

					2'b01: begin // On Zero
						DO_JUMP = SKIPF[0] ? CCZ : ~CCZ;
					end

					2'b10: begin // On Parity
						DO_JUMP = SKIPF[0] ? CCP : ~CCP;
					end

					2'b11: begin // On Negative
						DO_JUMP = SKIPF[0] ? CCV : ~CCV;
					end
				endcase
			end
			// Decode the target address
			if(DO_JUMP)
			begin
				case (JPF)
					2'b00: begin // JP Rb
						ALUX = 4'b0000;  // Use the MOV instruction to make the ALU copy ARG_B to the output
						ALU_SOURCEX = 2'b00; // Ra,Rb
						// We should force Ra to be 15 to point to the PC, but I'm going to 
						// rely on the assembler to do that
						// This means we have some "undocumented" conditional moves to all other registers :-)
					end
				endcase
			end
		end
			
		2'b11: begin // General
			ARGF = DINR[9:8];
			ALUF = DINR[13:10];
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