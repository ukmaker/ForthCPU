
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
	
	