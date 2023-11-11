`include "C:/Users/Duncan/git/ForthCPU/constants.v"
/*************************************************
* Takes control codes from the opxMultiplexer and 
* sequences register reads and writes
*      F      D     E     C     F
*       ___   ___   ___   ___   ___
*    ___   ___   ___   ___   ___   ___
*
*  A ===x=======================x=========
*  D =====x=======================x=======
* GPX=========x===========================
* OPX==========x==========================
* EN ____________---------------__________
* WEN_____________________------__________
* BYX____________---------------__________
* A0 ==============*======================
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
	
	input [1:0] REG_SEQX,
	
	input BYTEX,
	input A0,
	
	output reg [1:0] REGA_BYTE_EN,
	output reg REGA_EN,
	output reg REGA_WEN,
	output reg REGB_EN,
	output reg REGB_WEN
	
);

reg [1:0] REGA_BYTE_EN_R;
reg REGA_EN_R;
reg REGA_WEN_R;
reg REGB_EN_R;
reg REGB_WEN_R;
	
// byte decoding
always @(*) begin
	if(REG_SEQX == `REG_SEQX_UPA_RDB || REG_SEQX == `REG_SEQX_WRA_UPB) begin
		if(BYTEX == `BYTEX_WORD) begin
			REGA_BYTE_EN_R = `REG_BYTE_ENX_BOTH;
		end else begin
			if(A0) begin
				REGA_BYTE_EN_R = `REG_BYTE_ENX_HIGH;
			end else begin
				REGA_BYTE_EN_R = `REG_BYTE_ENX_LOW;
			end
		end
	end else if(REG_SEQX == `REG_SEQX_NONE) begin
		REGA_BYTE_EN_R = `REG_BYTE_ENX_NONE;
	end else begin
		REGA_BYTE_EN_R = `REG_BYTE_ENX_BOTH;
	end
end

// enables decoding
always @(*) begin

	case(REG_SEQX)
		`REG_SEQX_NONE: begin
			REGA_EN_R  = 0;
			REGA_WEN_R = 0;
			REGB_EN_R  = 0;
			REGB_WEN_R = 0;						
		end
			
		`REG_SEQX_RDA_RDB: begin
			REGA_EN_R  = 1;
			REGA_WEN_R = 0;
			REGB_EN_R  = 1;
			REGB_WEN_R = 0;						
		end	

		`REG_SEQX_UPA_RDB: begin
			REGA_EN_R  = 1;
			REGA_WEN_R = 1;
			REGB_EN_R  = 1;
			REGB_WEN_R = 0;						
		end
			
		`REG_SEQX_WRA_UPB: begin
			REGA_EN_R  = 1;
			REGA_WEN_R = 1;
			REGB_EN_R  = 1;
			REGB_WEN_R = 1;			
		end
	
		default: begin
			REGA_EN_R  = 0;
			REGA_WEN_R = 0;
			REGB_EN_R  = 0;
			REGB_WEN_R = 0;			
		end
	endcase
end

// sequence control
always @(posedge CLK or posedge RESET) begin
	if(RESET) begin
		REGA_EN  <= 0;
		REGA_WEN <= 0;
		REGB_EN  <= 0;
		REGB_WEN <= 0;
		REGA_EN_R  <= 0;
		REGA_WEN_R <= 0;
		REGB_EN_R  <= 0;
		REGB_WEN_R <= 0;
		REGA_BYTE_EN <= `REG_BYTE_ENX_NONE;
		REGA_BYTE_EN_R <= `REG_BYTE_ENX_NONE;
	end else begin
		if(FETCH) begin
			REGA_EN  <= 0;
			REGA_WEN <= 0;
			REGB_EN  <= 0;
			REGB_WEN <= 0;
			REGA_BYTE_EN <= `REG_BYTE_ENX_NONE;
		end else if(COMMIT) begin
			// wen high on posedge COMMIT
			REGA_WEN <= REGA_WEN_R;
			REGB_WEN <= REGB_WEN_R;
		end
	end
end
			
always @(negedge CLK) begin
	if(EXECUTE) begin
		// activate EN and BYTEX
		REGA_BYTE_EN <= REGA_BYTE_EN_R;
		REGA_EN      <= REGA_EN_R;
		REGB_EN      <= REGB_EN_R;
	end
end

endmodule