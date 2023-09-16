library verilog;
use verilog.vl_types.all;
entity cfg_act_senser is
    port(
        cfg_access_ok   : out    vl_logic;
        trcv_async_rst  : in     vl_logic;
        scl_clk         : in     vl_logic;
        addr_match_cfg  : in     vl_logic
    );
end cfg_act_senser;
