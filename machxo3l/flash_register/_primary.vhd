library verilog;
use verilog.vl_types.all;
entity flash_register is
    port(
        flash_sec_prog  : out    vl_logic;
        flash_sec_read  : out    vl_logic;
        flash_secplus   : out    vl_logic;
        flash_done      : out    vl_logic;
        flash_ues       : out    vl_logic_vector(31 downto 0);
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        scanen          : in     vl_logic;
        exec_load_ues   : in     vl_logic;
        fl_set_sec      : in     vl_logic;
        fl_set_secplus  : in     vl_logic;
        fl_set_done     : in     vl_logic;
        fl_erase_ues    : in     vl_logic;
        fl_erase_success: in     vl_logic;
        dnld_load_ues   : in     vl_logic;
        fl_exec_buf     : in     vl_logic_vector(127 downto 0)
    );
end flash_register;
