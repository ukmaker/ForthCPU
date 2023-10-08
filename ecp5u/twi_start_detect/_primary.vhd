library verilog;
use verilog.vl_types.all;
entity twi_start_detect is
    port(
        twi_wdat_posedge: out    vl_logic;
        twi_start_d_0   : out    vl_logic;
        twi_start_d     : out    vl_logic;
        twi_start_d_2   : out    vl_logic;
        twi_resetb      : in     vl_logic;
        twi_clk         : in     vl_logic;
        twi_wdat        : in     vl_logic
    );
end twi_start_detect;
