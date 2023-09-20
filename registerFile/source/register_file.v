`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module register_file(

	input CLK,
	input RESET,

	/**
	* Port A inputs
	**/
	input [15:0] ALU_R,
	input [15:0] PC_A,
	input [15:0] ALUA_PP,
	/**
	* Port B inputs
	**/
	input [15:0] DIN,
	
	/**
	* Port A controls
	**/
	input REGA_EN,
	input REGA_WEN,
	input [3:0] ARGA_X,
	input [2:0] REGA_ADDRX,
	input [1:0] REGA_DINX,
	
	/**
	* Port B controls
	**/
	input REGB_EN,
	input REGB_WEN,
	input [3:0] ARGB_X,
	input [1:0] REGB_ADDRX,
	
	output wire [15:0] REGA_DOUT,
	output wire [15:0] REGB_DOUT
);

/**
* internal wires
**/
reg [15:0] DINA;
reg [3:0] ADDRA;
reg [3:0] ADDRB;

dpram registers(
	.DataInA( DINA ), 
	.DataInB( DIN ), 
	.AddressA( ADDRA ), 
	.AddressB( ADDRB ), 
    .ClockA( CLK ), 
	.ClockB( CLK  ), 
	.ClockEnA( REGA_EN ), 
	.ClockEnB( REGB_EN), 
	.WrA( REGA_WEN ), 
	.WrB( REGB_WEN), 
    .ResetA( RESET ), 
	.ResetB( RESET ), 
	.QA( REGA_DOUT ), 
	.QB( REGB_DOUT )
);

always @(REGA_ADDRX) begin
	case(REGA_ADDRX)
		`REGA_ADDRX_ARGA: ADDRA = ARGA_X;
		`REGA_ADDRX_RL:   ADDRA = `RLN;
		`REGA_ADDRX_RA:   ADDRA = `RA;
		`REGA_ADDRX_RB:   ADDRA = `RB;
		`REGA_ADDRX_RSP:  ADDRA = `RSP;
		`REGA_ADDRX_RFP:  ADDRA = `RFP;
		`REGA_ADDRX_RRS:  ADDRA = `RRS;
		default:          ADDRA = ARGA_X;
	endcase
end

always @(REGA_DINX) begin
	case(REGA_DINX)
		`REGA_DINX_ALU_R:   DINA = ALU_R;
		`REGA_DINX_PC_A:    DINA = PC_A;
		`REGA_DINX_ALUA_PP: DINA = ALUA_PP;
		default:            DINA = ALU_R;
	endcase
end
	
always @(REGB_ADDRX) begin
	case(REGB_ADDRX)
		`REGB_ADDRX_ARGA: ADDRB = ARGA_X;
		`REGB_ADDRX_ARGB: ADDRB = ARGB_X;
		`REGB_ADDRX_RB:   ADDRB = `RB;
		default:          ADDRB = ARGB_X;
	endcase
end


endmodule