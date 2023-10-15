/************************************************
* Very high-level tests which just drive the bus
*************************************************/
`define CLOCK_CYCLE 100
`define INSTRUCTION_CYCLE 400
`define TICK #(50)
`define TOCK #(50)
`define TICKTOCK #(`CLOCK_CYCLE)
`define STEP     #(`INSTRUCTION_CYCLE)

`define assert(what, expected, actual) \
    if (expected !== actual) begin \
        $display("[T=%0t] FAILED in %m: %s expected %b != actual %b", $realtime, what, expected, actual); \
    end

`define mark(n)  \
	$display("[T=%09t] %d", $realtime, n);
	
`define ALU_STEP(n, addr, instruction, m) \
	$display("FETCH   [T=%09t] %04d {%04x} :: {%04x} %s", $realtime, n, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("DECODE  [T=%09t]", $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("EXECUTE  [T=%09t]", $realtime); \
	`TICKTOCK; \
	$display("COMMIT  [T=%09t]", $realtime); \
	`TICKTOCK;
	
`define ST_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("FETCH   [T=%09t] %04d {%04x} :: {%04x} %s", $realtime, n, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("DECODE  [T=%09t]", $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("EXECUTE  [T=%09t]", $realtime); \
	`TICKTOCK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	$display("COMMIT  [T=%09t]", $realtime); \
	`TICK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 0, WRN0_BUF) \
	`assert("WRN1_BUF", 0, WRN1_BUF) \
	`TOCK;
	
	
`define LD_STEP(n, addr, instruction, ld_addr,ld_data, m) \
	$display("FETCH   [T=%09t] %04d {%04x} :: {%04x} %s", $realtime, n, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("DECODE  [T=%09t]", $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("EXECUTE  [T=%09t]", $realtime); \
	`TICKTOCK; \
	$display("COMMIT  [T=%09t]", $realtime); \
	`TICK; \
	DIN = ld_data; \
	`assert("ADDR_BUF", ld_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;
	
`define LOAD(n, addr, rr, value) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_XOR,`MODE_ALU_REG_REG, `R0,`R1}; \
	`ALU_STEP( n,addr,   INSTR, "XOR R0,R0") \
	INSTR = {`GROUP_LOAD_STORE,`LDSINCF_NONE,`LDSOPF_LD,`MODE_LDS_REG_MEM, rr,`R0}; \
	`LD_STEP(n+1, addr+2, INSTR, 16'h0000, value, "LD rr,(R0)")
	

	
	