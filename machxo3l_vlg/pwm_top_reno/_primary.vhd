library verilog;
use verilog.vl_types.all;
entity pwm_top_reno is
    port(
        mclk            : in     vl_logic;
        resetb          : in     vl_logic;
        pwm_enable      : in     vl_logic_vector(4 downto 1);
        pwm_out         : out    vl_logic_vector(4 downto 1);
        cfg_pwm_enable_1: in     vl_logic;
        cfg_pwm_enable_2: in     vl_logic;
        cfg_pwm_enable_3: in     vl_logic;
        cfg_pwm_enable_4: in     vl_logic;
        cfg_pwm_pwidth_1: in     vl_logic_vector(3 downto 0);
        cfg_pwm_pwidth_2: in     vl_logic_vector(3 downto 0);
        cfg_pwm_pwidth_3: in     vl_logic_vector(3 downto 0);
        cfg_pwm_pwidth_4: in     vl_logic_vector(3 downto 0);
        cfg_pwm_freq_1  : in     vl_logic;
        cfg_pwm_freq_2  : in     vl_logic;
        cfg_pwm_freq_3  : in     vl_logic;
        cfg_pwm_freq_4  : in     vl_logic;
        safestate_iob   : in     vl_logic
    );
end pwm_top_reno;
