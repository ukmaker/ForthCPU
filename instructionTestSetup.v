/************************************************
* Very high-level tests which just drive the bus
*************************************************/
`include "./testSetup.v"
	
`define ALU_STEP(n, addr, instruction, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]",  n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE [T=%09t]",  n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]",  n, $realtime); \
	`TICKTOCK;

`define ST_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime,addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 0, WRN0_BUF) \
	`assert("WRN1_BUF", 0, WRN1_BUF) \
	`TOCK;
	

`define ST_LOW_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 0, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;
	
	

`define ST_HIGH_STEP(n, addr, instruction, st_addr, st_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	`assert("ADDR_BUF", st_addr, ADDR_BUF) \
	`assert("DOUT_BUF", st_data, DOUT_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 0, WRN1_BUF) \
	`TOCK;
	
	
`define LD_STEP(n, addr, instruction, ld_addr,ld_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = ld_data; \
	`assert("ADDR_BUF", ld_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;
	
	
`define LD_HERE_STEP(n, addr, ld_data, rr) \
	$display("%04d LOAD    [T=%09t] R%02x, %04x", n, $realtime, rr, ld_data); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = {`GROUP_LOAD_STORE, 1'b0, `LDSOPF_LD, `MODE_LDS_REG_HERE, rr, 4'b0000}; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = ld_data; \
	`assert("ADDR_BUF", addr+2, ADDR_BUF) \
	`assert("WRN0_BUF", 1,      WRN0_BUF) \
	`assert("WRN1_BUF", 1,      WRN1_BUF) \
	`TOCK;

`define SYS_STEP(n, addr, instruction, sys_addr, sys_data, m) \
	$display("%04d FETCH   [T=%09t] {%04x} :: {%04x} %s", n, $realtime, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50 \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	$display("%04d DECODE  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK; \
	$display("%04d EXECUTE  [T=%09t]", n, $realtime); \
	`TICKTOCK; \
	$display("%04d COMMIT  [T=%09t]", n, $realtime); \
	`TICK; \
	DIN = sys_data; \
	`assert("ADDR_BUF", sys_addr, ADDR_BUF) \
	`assert("WRN0_BUF", 1, WRN0_BUF) \
	`assert("WRN1_BUF", 1, WRN1_BUF) \
	`TOCK;

`define MOV(n, addr, a, b) \
	INSTR = {`GROUP_ARITHMETIC_LOGIC,`ALU_OPX_MOV,`MODE_ALU_REG_REG, a, b}; \
	`ALU_STEP(  n, addr,   INSTR, $sformatf("MOV R%2x,R%2x", a, b))
	

	