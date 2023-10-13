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

reg [15:0] ADDR;
reg [15:0] ADDR_NEXT;
reg [15:0] DOUT;
reg [15:0] DIN;

reg RDN;
reg WRN;

reg [1:0] STATE;

reg READ;
reg WRITE;

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

always @(posedge CLK) begin
	if(FETCH) begin
		#5 RDN = 1; WRN = 1;
		ADDR = ADDR_NEXT;
		ADDR_NEXT = ADDR_NEXT + 2;
		DIN = 16'hzzzz;
		DOUT = 16'hzzzz;
		#50 RDN = 0;
		#30 DIN = 16'haced;
	end else if(DECODE) begin
		#50 RDN = 1;
		#5 DIN = 16'hzzzz;
	end else if(EXECUTE) begin
		if(READ) begin
			#5 RDN = 0;
			#70 ADDR = 16'hdead;
		end else if(WRITE) begin
			#70 ADDR = 16'hd00d; DOUT = 16'h8080;
		end
	end else if(COMMIT) begin
		if(READ) begin
			#50 DIN = 16'hbeef;
		end else if(WRITE) begin
			#5 WRN = 0;
		end
	end
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
	DIN     = 16'h0000;
	DOUT    = 16'h0000;
	ADDR    = 16'hffff;
	RDN     = 1;
	WRN     = 1;
	READ = 0;
	WRITE = 0;
	ADDR_NEXT = 0;
	
	`TICKTOCK;
	RESET = 0;  
	`TICKTOCK;

	`STEP;
	READ = 1;
	`STEP;
	READ = 0;
	WRITE = 1;
	`STEP;
	WRITE = 0;
	`STEP;
	

end

endmodule