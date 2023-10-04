`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module registerFile(

	input CLK,
	input RESET,

	/**
	* Port A input
	**/
	input [15:0] ALU_R,

	/**
	* Port B inputs
	**/
	input [15:0] DIN,
	input [15:0] PC_A,
	
	/**
	* Port A controls
	**/
	input REGA_EN,
	input REGA_WEN,
	input [1:0] REGA_BYTE_EN,
	input [3:0] ARGA_X,
	input [2:0] REGA_ADDRX,
	
	/**
	* Port B controls
	**/
	input REGB_EN,
	input REGB_WEN,
	input [1:0] REGB_BYTE_EN,
	input [3:0] ARGB_X,
	input [1:0] REGB_DINX,
	input [1:0] REGB_ADDRX,
	
	output wire [15:0] REGA_DOUT,
	output wire [15:0] REGB_DOUT
);

/**
* internal wires
**/
reg [15:0] DINB;
wire [15:0] DINH;
reg [3:0] ADDRA;
reg [3:0] ADDRB;

registers regs(
	.DataInA( ALU_R ), 
	.DataInB( DINB ), 
	.AddressA( ADDRA ), 
	.AddressB( ADDRB ), 
    .ClockA( CLK ), 
	.ClockB( CLK  ), 
	.ClockEnA( REGA_EN ), 
	.ClockEnB( REGB_EN), 
	.WrA( REGA_WEN ), 
	.WrB( REGB_WEN), 
	.ByteEnA(REGA_BYTE_EN),
	.ByteEnB(REGB_BYTE_EN),
    .ResetA( RESET ), 
	.ResetB( RESET ), 
	.QA( REGA_DOUT ), 
	.QB( REGB_DOUT )
);

assign DINH = {8'h00,DIN[15:8]};

always @(*) begin
		
	case(REGB_DINX)
		`REGB_DINX_DIN:     DINB = ALU_R;
		`REGB_DINX_DINH:    DINB = DINH;
		`REGB_DINX_PC_A:    DINB = PC_A;
		default:            DINB = ALU_R;
	endcase
	
	case(REGA_ADDRX)
		`REGA_ADDRX_ARGA: ADDRA = ARGA_X;
		`REGA_ADDRX_RA:   ADDRA = `RA;
		`REGA_ADDRX_RB:   ADDRA = `RB;
		`REGA_ADDRX_RSP:  ADDRA = `RSP;
		`REGA_ADDRX_RFP:  ADDRA = `RFP;
		`REGA_ADDRX_RRS:  ADDRA = `RRS;
		default:          ADDRA = ARGA_X;
	endcase

	case(REGB_ADDRX)
		`REGB_ADDRX_ARGB: ADDRB = ARGB_X;
		`REGB_ADDRX_RB:   ADDRB = `RB;
		`REGB_ADDRX_RL:   ADDRB = `RL;
		default:          ADDRB = ARGB_X;
	endcase
end


endmodule