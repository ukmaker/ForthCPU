
`define CLOCK_CYCLE 100
`define INSTRUCTION_CYCLE 400
`define TICK #(50)
`define TOCK #(50)
`define TICKTOCK #(`CLOCK_CYCLE)
`define STEP     #(`INSTRUCTION_CYCLE)

`define assert(what, expected, actual) \
    if (actual !== expected) begin \
        $display("[T=%0t] FAILED in %m: %s expected %b != actual %b", $realtime, what, expected, actual); \
    end else begin \
        $display("[T=%0t]                                             passed in %m: %s expected %b actual %b", $realtime, what, expected, actual); \
	end
	
`define sassert(step, what, expected, actual) \
    if (actual !== expected) begin \
        $display("[T=%0t] %d FAILED in %m: %s expected %b != actual %b", $realtime, step, what, expected, actual); \
    end else begin \
        $display("[T=%0t] %d passed in %m: %s expected %b actual %b", $realtime, step, what, expected, actual); \
	end

`define asserth(what, expected, actual) \
    if (actual !== expected) begin \
        $display("[T=%0t] FAILED in %m: %s expected %04x != actual %04x", $realtime, what, expected, actual); \
    end else begin \
        $display("[T=%0t]                                             passed in %m: %s expected %04x actual %04x", $realtime, what, expected, actual); \
	end

`define mark(n)  \
	$display("[T=%09t] %d", $realtime, n);
	
`define step(n, m)  \
	$display("[T=%09t] %d %s", $realtime, n, m);
	
`define comment(c) \
	$display("[T=%09t] %s", $realtime, c); \
	`TICKTOCK;
	
`define FETCH(n, addr, instruction, m) \
	$display("FETCH   [T=%09t] %04d {%04x} :: {%04x} %s", $realtime, n, addr, instruction, m); \
	#1 \
	`assert("ADDR", addr, ADDR_BUF) \
	#49 DIN = instruction; \
	#50
	
`define NFETCH(n, addr, instruction, m) \
	$display("FETCH   [T=%09t] %04d {%04x} :: {%04x} %s", $realtime, n, addr, instruction, m); \
	#50 DIN = instruction; \
	#50
	
`define DECODE(n, m) \
	$display("DECODE  [T=%09t] %04d %s", $realtime, n, m); \
	`TICK; \
	DIN = 16'hzzzz; \
	`TOCK;
	
`define EXECUTE(n,m) \
	$display("EXECUTE [T=%09t] %04d %s", $realtime, n, m); 
	
`define COMMIT(n,m) \
	$display("COMMIT  [T=%09t] %04d %s", $realtime, n, m); 

`define internalCycle(addr, inst) \
	FETCH = 1;   \
	`TICKTOCK;   \
	FETCH = 0;   \
	DECODE = 1;  \
	`TICK;       \
	ADDR = addr; \
	`TOCK;       \
	DECODE = 0;  \
	EXECUTE = 1; \
	DIN = inst;  \
	`TICKTOCK;   \
	EXECUTE = 0; \
	COMMIT = 1;  \
	`TICKTOCK;   \
	COMMIT = 0;
	
`define externalCycle(addr, inst, argAddr, argData) \
	FETCH = 1;      \
	`TICKTOCK;      \
	FETCH = 0;      \
	DECODE = 1;     \
	`TICK;          \
	ADDR = addr;    \
	`TOCK;          \
	DECODE = 0;     \
	EXECUTE = 1;    \
	DIN = inst;     \
	`TICK;          \
	RD = 1;         \
	`TOCK;          \
	EXECUTE = 0;    \
	COMMIT = 1;     \
	`TICK;          \
	ADDR = argAddr; \
	DIN = argData;  \
	`TOCK;          \
	COMMIT = 0;    \
	RD = 0;
