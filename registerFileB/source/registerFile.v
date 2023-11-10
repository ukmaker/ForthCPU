`include "C:/Users/Duncan/git/ForthCPU/constants.v"

module registerFile(

	input CLK,
	input RESET,

	/**
	* Data inputs
	**/
	input [15:0] ALU_R,
	input [15:0] DIN,
	input [15:0] HERE,
	
	/**
	* Port A controls
	**/
	input REGA_EN,
	input REGA_WEN,
	input [1:0] REGA_BYTE_EN,
	input [3:0] ARGA_X,
	input [1:0] REGA_ADDRX,
	input [1:0] REGA_DINX,
	input        REGA_BYTEX,
	
	/**
	* Port B controls
	**/
	input REGB_EN,
	input REGB_WEN,
	input [1:0] REGB_BYTE_EN,
	input [3:0] ARGB_X,
	input [2:0] REGB_ADDRX,
	
	output wire [15:0] REGA_DOUT,
	output wire [15:0] REGB_DOUT
);

/**
* internal wires
**/
reg [15:0] DINA;
reg [15:0] DIN_BYTE_LOW;
reg [15:0] DIN_BYTE_HIGH;
reg [15:0] DIN_BYTE;
reg [3:0] ADDRA;
reg [3:0] ADDRB;

registers regs(
	.DataInA( DINA ), 
	.DataInB( ALU_R ), 
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



always @(*) begin
	
	DIN_BYTE_LOW  = {8'h00,DIN[7:0]};
	DIN_BYTE_HIGH = {8'h00,DIN[15:8]};	
	
	case(REGA_BYTEX)
		`REGA_BYTEX_HIGH:   DIN_BYTE = DIN_BYTE_HIGH;
		default:            DIN_BYTE = DIN_BYTE_LOW;
	endcase
	
	case(REGA_DINX)
		`REGA_DINX_DIN:          DINA = DIN;
		`REGA_DINX_BYTE:         DINA = DIN_BYTE;
		`REGA_DINX_HERE:         DINA = HERE;
		default:                 DINA = ALU_R;
	endcase
	
	case(REGA_ADDRX)
		`REGA_ADDRX_RA:   ADDRA = `RA;
		`REGA_ADDRX_RB:   ADDRA = `RB;
		`REGA_ADDRX_RL:   ADDRA = `RL;
		default:          ADDRA = ARGA_X;
	endcase	
	
	case(REGB_ADDRX)
		`REGB_ADDRX_RB:   ADDRB = `RB;
		`REGB_ADDRX_RSP:  ADDRB = `RSP;
		`REGB_ADDRX_RFP:  ADDRB = `RFP;
		`REGB_ADDRX_RRS:  ADDRB = `RRS;
		default:          ADDRB = ARGB_X;
	endcase


end


endmodule