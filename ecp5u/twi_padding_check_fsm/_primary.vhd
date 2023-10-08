library verilog;
use verilog.vl_types.all;
entity twi_padding_check_fsm is
    generic(
        idle_d          : integer := 0;
        pad_0_d         : integer := 1;
        pad_1_d         : integer := 3;
        pad_e_d         : integer := 2
    );
    port(
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_padding_start: in     vl_logic;
        twi_padding_end : in     vl_logic;
        twi_padding_bit : in     vl_logic;
        twi_clr_padding_error: in     vl_logic;
        twi_padding_error_d: out    vl_logic
    );
end twi_padding_check_fsm;
