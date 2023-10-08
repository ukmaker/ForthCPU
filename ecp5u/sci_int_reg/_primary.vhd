library verilog;
use verilog.vl_types.all;
entity sci_int_reg is
    port(
        status          : out    vl_logic;
        rst_async       : in     vl_logic;
        sb_clk_i        : in     vl_logic;
        int_force       : in     vl_logic;
        int_set         : in     vl_logic;
        int_clr         : in     vl_logic;
        scan_test_mode  : in     vl_logic
    );
end sci_int_reg;
