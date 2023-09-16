library verilog;
use verilog.vl_types.all;
entity sig_sync is
    port(
        cfg_port_active_sync: out    vl_logic;
        scl_clk         : in     vl_logic;
        i2c_rst_async   : in     vl_logic;
        cfg_port_active : in     vl_logic
    );
end sig_sync;
