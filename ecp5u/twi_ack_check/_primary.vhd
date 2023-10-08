library verilog;
use verilog.vl_types.all;
entity twi_ack_check is
    port(
        twi_invalid_ack_nack: out    vl_logic;
        twi_nack_rcvd   : out    vl_logic;
        twi_clk         : in     vl_logic;
        twi_resetb      : in     vl_logic;
        twi_clr_ack_nack_flag: in     vl_logic;
        twi_chk_ack_enable: in     vl_logic;
        twi_wdat_frame  : in     vl_logic_vector(7 downto 0)
    );
end twi_ack_check;
