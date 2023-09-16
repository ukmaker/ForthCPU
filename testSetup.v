
`define CLOCK_CYCLE 100
`define INSTRUCTION_CYCLE 800
`define TICK #(50)
`define TICKTOCK #(`CLOCK_CYCLE)

`define assert(what, expected, actual) \
    if (expected !== actual) begin \
        $display("[T=%0t] FAILED in %m: %s expected %b != actual %b", $realtime, what, expected, actual); \
    end
