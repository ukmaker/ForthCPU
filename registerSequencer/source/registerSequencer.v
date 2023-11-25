`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/*************************************************
* Takes control codes from the opxMultiplexer and 
* sequences register reads and writes
*      F      D     E     C     F
*       ___   ___   ___   ___   ___
*    ___   ___   ___   ___   ___   ___
*
*  A <===x=======================x=========
*  D <=====x=======================x=======
* GPX=========x===========================
* OPX==========x==========================
* EN ____________---------------__________
* WEN_____________________------__________
* BYX____________---------------__________
* A0 <==============*======================
*       ^ ------------------------------   Instruction address output
*         ^ ----------------------------   Instruction data valid
*             ^ ------------------------   GROUPX valid for opxMultiplexer
*              ^ -----------------------   Correct OPX decoded
*                ^ ---------------------   Byte controls (reg writes)
*                ^ ---------------------   Control sequence started (reg reads)
*                  ^ -------------------   Reg out to A0 valid (byte ops)
*                         ^ ------------   Control sequence (reg writes)

*
* OPX means the instruction decodes from the opxMux for:
*
*  - REG_SEQX : what kind of register cycle to run
*  - BYTEX    : word or byte operation
*
**************************************************/
module registerSequencer(
	
	input CLK,
	input RESET,
	input FETCH,
	input DECODE,
	input EXECUTE,
	input COMMIT,
	
	input [3:0] REG_SEQX,
	
	input BYTEX,
	input A0,
	
	output reg REGA_EN,
	output reg REGA_WEN,
	output reg REGB_EN,
	output reg REGB_WEN
	
);

reg REGA_EN_R;
reg REGA_WEN_R;
reg REGB_EN_R;
reg REGB_WEN_R;

reg RD_EN; // Gated clock signals
reg WR_EN;

// enables decoding
always @(posedge CLK or posedge RESET) begin
	
	if(FETCH | RESET) begin
			REGA_EN_R  <= 0;
			REGA_WEN_R <= 0;
			REGB_EN_R  <= 0;
			REGB_WEN_R <= 0;	
	end else if(DECODE) begin

		case(REG_SEQX)
			`REG_SEQX_NONE: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 0;
				REGB_WEN_R <= 0;						
			end
				
			`REG_SEQX_RDA_RDB: begin
				REGA_EN_R  <= 1;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 0;						
			end	

			`REG_SEQX_LDA_RDB: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 1;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 0;						
			end
				
			`REG_SEQX_LDA_UPB: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 1;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 1;			
			end
			
			`REG_SEQX_RDA_UPB: begin
				REGA_EN_R  <= 1;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 1;		
			end
		
			`REG_SEQX_LDA_IMM: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 1;
				REGB_EN_R  <= 0;
				REGB_WEN_R <= 0;		
			end
			
			`REG_SEQX_RDA_IMM: begin
				REGA_EN_R  <= 1;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 0;
				REGB_WEN_R <= 0;		
			end
			
			`REG_SEQX_UPA_RDB: begin
				REGA_EN_R  <= 1;
				REGA_WEN_R <= 1;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 0;		
			end
			
			`REG_SEQX_UPA_IMM: begin
				REGA_EN_R  <= 1;
				REGA_WEN_R <= 1;
				REGB_EN_R  <= 0;
				REGB_WEN_R <= 0;		
			end
			
			`REG_SEQX_RDB: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 1;
				REGB_WEN_R <= 0;				
			end
		
			default: begin
				REGA_EN_R  <= 0;
				REGA_WEN_R <= 0;
				REGB_EN_R  <= 0;
				REGB_WEN_R <= 0;			
			end
		endcase
	end
end

always @(negedge CLK) begin
	RD_EN <= EXECUTE;
end

// sequence control
// Read REG_EN go high on the falling edge of CLK during DECODE
// i.e. while EXECUTE is high
// then low again during CLK low in COMMIT
// Write REG_EN and REG_WEN go high on the rising edge of CLK 
// during COMMIT (while FETCH is high)
always @(*) begin
	// It doesn't matter if these signals glitch a bit
	// since everything is ultimately synced to the 
	// rising egde of CLK
	WR_EN = FETCH;
	
	REGA_EN = (RD_EN & REGA_EN_R) | (WR_EN & REGA_WEN_R);
	REGB_EN = (RD_EN & REGB_EN_R) | (WR_EN & REGB_WEN_R);
	REGA_WEN = WR_EN & REGA_WEN_R;
	REGB_WEN = WR_EN & REGB_WEN_R;

end

endmodule