`timescale 1 ns / 1 ns
`include "../../constants.v"
`include "../../testSetup.v"

module timingModel;

reg CLK;
reg RESET;
reg FETCH;
reg DECODE;
reg EXECUTE;
reg COMMIT;
reg STOPPED;

reg [15:0] ADDR;
reg [15:0] ADDR_NEXT;
reg [15:0] DOUT;
reg [15:0] DIN;

reg [1:0] STATE;

reg [2:0] ADDR_BUSX;

reg [3:0] REG_SEQX;
reg [1:0] BUS_SEQX;

reg A0;
reg BYTEX;

wire [2:0] ADDR_BUSX_R;
wire REGA_EN;
wire REGB_EN;
wire REGA_WEN;
wire REGB_WEN;

wire RDN_BUF;
wire WRN0_BUF;
wire WRN1_BUF;

busSequencer busSq(
	
	.CLK(CLK),
	.RESET(RESET),

	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	
	.A0(A0),
	.BYTEX(BYTEX),

	.BUS_SEQX(BUS_SEQX),
	
	.ADDR_BUSX(ADDR_BUSX),
	.ADDR_BUSX_R(ADDR_BUSX_R),

	.RDN_BUF(RDN_BUF),
	.WRN0_BUF(WRN0_BUF),
	.WRN1_BUF(WRN1_BUF)
);


registerSequencer regSq(
	
	.CLK(CLK),
	.RESET(RESET),

	.FETCH(FETCH),
	.DECODE(DECODE),
	.EXECUTE(EXECUTE),
	.COMMIT(COMMIT),
	.STOPPED(STOPPED),
	
	.REG_SEQX(REG_SEQX),
	
	.REGA_EN(REGA_EN),
	.REGA_WEN(REGA_WEN),
	.REGB_EN(REGB_EN),
	.REGB_WEN(REGB_WEN)
	
);

// clk gen
always begin
	#50 CLK = ~CLK;
end

always @(posedge CLK) begin
	#10 STATE   = STATE + 1;
	FETCH   = (STATE == 2'b00);
	DECODE  = (STATE == 2'b01);
	EXECUTE = (STATE == 2'b10);
	COMMIT  = (STATE == 2'b11);
end


initial begin
	#10
	CLK = 0; 
	`TICK;
	RESET = 1;
	`TICKTOCK;
	STATE   = 2'b11;
	FETCH   = 0;
	DECODE  = 0;
	EXECUTE = 0;
	COMMIT  = 0;
	STOPPED = 0;
	DIN     = 16'h0000;
	DOUT    = 16'h0000;
	ADDR    = 16'hffff;
	ADDR_NEXT = 0;
	A0 = 1'b0;
	BYTEX = `BYTEX_WORD;
	
	ADDR_BUSX = `ALUA_SRCX_REG_A;
	BUS_SEQX = `BUS_SEQX_NONE;
	REG_SEQX = `REG_SEQX_NONE;
	
	`TICKTOCK;
	RESET = 0;
	
	// Internal only cycle
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(1, "FETCH")
	`step(2, "DECODE")
	`step(3, "EXECUTE - MEMORY READ")
	`step(4, "COMMIT")
	
	// memory read
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(5, "FETCH")
	BUS_SEQX = `BUS_SEQX_READ;
	`step(6, "DECODE")
	`step(7, "EXECUTE - MEMORY READ")
	`step(8, "COMMIT")
		
	// memory write
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(9, "FETCH")
	BUS_SEQX = `BUS_SEQX_WRITE;
	`step(10, "DECODE")
	`step(11, "EXECUTE - MEMORY WRITE")
	`step(12, "COMMIT")
	
	// ALU only
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(13, "FETCH")
	REG_SEQX = `REG_SEQX_RDA_RDB;
	`step(14, "DECODE")
	`step(15, "EXECUTE - REG_SEQX_RDA_RDB")
	`step(16, "COMMIT")
	
	// ALU with result
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(17, "FETCH")
	REG_SEQX = `REG_SEQX_LDA_RDB;
	`step(18, "DECODE")
	`step(19, "EXECUTE - REG_SEQX_LDA_RDB")
	`step(20, "COMMIT")
	
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(21, "FETCH")
	REG_SEQX = `REG_SEQX_LDA_UPB;
	`step(22, "DECODE")
	`step(23, "EXECUTE - REG_SEQX_LDA_UPB")
	`step(24, "COMMIT")
	
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(25, "FETCH")
	REG_SEQX = `REG_SEQX_RDA_UPB;
	`step(26, "DECODE")
	`step(27, "EXECUTE - REG_SEQX_RDA_UPB")
	`step(28, "COMMIT")
	
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(29, "FETCH")
	REG_SEQX = `REG_SEQX_LDA_IMM;
	`step(30, "DECODE")
	`step(31, "EXECUTE - REG_SEQX_LDA_IMM")
	`step(32, "COMMIT")
	
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(33, "FETCH")
	REG_SEQX = `REG_SEQX_RDA_IMM;
	`step(34, "DECODE")
	`step(35, "EXECUTE - REG_SEQX_RDA_IMM")
	`step(36, "COMMIT")
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(37, "FETCH")
	REG_SEQX = `REG_SEQX_UPA_RDB;
	`step(38, "DECODE")
	`step(39, "EXECUTE - REG_SEQX_UPA_RDB")
	`step(40, "COMMIT")

	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(41, "FETCH")
	REG_SEQX = `REG_SEQX_UPA_IMM;
	`step(42, "DECODE")
	`step(43, "EXECUTE - REG_SEQX_UPA_IMM")
	`step(44, "COMMIT")

	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(45, "FETCH")
	REG_SEQX = `REG_SEQX_RDB;
	`step(46, "DECODE")
	`step(47, "EXECUTE - REG_SEQX_RDB")
	`step(48, "COMMIT")

	// LD Ra,(HERE)
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(49, "FETCH")
	BUS_SEQX = `BUS_SEQX_READ;
	REG_SEQX = `REG_SEQX_LDA_IMM;
	`step(50, "DECODE")
	`step(51, "EXECUTE - LD Ra,(HERE)")
	`step(52, "COMMIT")

	// LD Ra,(Rb)
	BUS_SEQX = `BUS_SEQX_FETCH;
	`step(53, "FETCH")
	BUS_SEQX = `BUS_SEQX_READ;
	REG_SEQX = `REG_SEQX_LDA_RDB;
	`step(54, "DECODE")
	`step(55, "EXECUTE - LD Ra,(Rb)")
	`step(56, "COMMIT")



end

endmodule