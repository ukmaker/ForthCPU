library verilog;
use verilog.vl_types.all;
entity wr_pulse is
    port(
        enable          : in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        pulse           : out    vl_logic
    );
end wr_pulse;
