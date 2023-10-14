
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
	
`define FETCH(n, din, m) \
	$display("FETCH   [T=%09t] %04d {%04x} %s", $realtime, n, din, m); \
	`TICKTOCK
	
`define DECODE(n,m) \
	$display("DECODE  [T=%09t] %04d %s", $realtime, n, m); \
	`TICKTOCK
	
`define EXECUTE(n,m) \
	$display("EXECUTE [T=%09t] %04d %s", $realtime, n, m); \
	`TICKTOCK
	
`define COMMIT(n,m) \
	$display("COMMIT  [T=%09t] %04d %s", $realtime, n, m); \
	`TICKTOCK
	
	