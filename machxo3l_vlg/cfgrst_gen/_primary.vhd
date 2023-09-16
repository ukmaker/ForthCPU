library verilog;
use verilog.vl_types.all;
entity cfgrst_gen is
    port(
        i2c_cfgrst      : out    vl_logic;
        trcv_async_rst  : in     vl_logic;
        scl_clk         : in     vl_logic;
        addr_mrst7      : in     vl_logic;
        addr_mrst10     : in     vl_logic;
        info_cfgrst     : in     vl_logic
    );
end cfgrst_gen;
