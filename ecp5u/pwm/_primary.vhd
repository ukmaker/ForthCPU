library verilog;
use verilog.vl_types.all;
entity pwm is
    generic(
        DATAWIDTH       : integer := 5;
        STROBEWIDTH     : integer := 5
    );
    port(
        pwm_clk         : in     vl_logic;
        pwm_resetb      : in     vl_logic;
        pwm_enable      : in     vl_logic;
        pwm_freq_config : in     vl_logic;
        pwm_pw_config   : in     vl_logic_vector(3 downto 0);
        pwm_dout_d      : out    vl_logic
    );
end pwm;
