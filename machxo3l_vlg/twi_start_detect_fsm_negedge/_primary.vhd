library verilog;
use verilog.vl_types.all;
entity twi_start_detect_fsm_negedge is
    generic(
        ST_RESET        : integer := 0;
        ST_WDAT_WAIT_1  : integer := 1;
        ST_WDAT_WAIT_0  : integer := 2;
        ST_VLD_START    : integer := 3
    );
    port(
        twi_start_seq_negedge: out    vl_logic;
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_wdat        : in     vl_logic
    );
end twi_start_detect_fsm_negedge;
