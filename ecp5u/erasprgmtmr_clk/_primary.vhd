library verilog;
use verilog.vl_types.all;
entity erasprgmtmr_clk is
    port(
        clk_250khz      : out    vl_logic;
        clk_1khz        : out    vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        clk             : in     vl_logic
    );
end erasprgmtmr_clk;
