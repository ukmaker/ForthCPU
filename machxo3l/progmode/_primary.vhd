library verilog;
use verilog.vl_types.all;
entity progmode is
    port(
        prgm_mode       : out    vl_logic;
        reset           : in     vl_logic;
        prgmmode_ld_reg : in     vl_logic;
        addrbit0        : in     vl_logic;
        mc_bus          : in     vl_logic_vector(7 downto 0);
        usermode_iflg   : in     vl_logic;
        erase_prgrm_active: in     vl_logic;
        clk             : in     vl_logic;
        twi_fl_prgm_eep : in     vl_logic
    );
end progmode;
