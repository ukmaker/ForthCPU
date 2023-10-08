library verilog;
use verilog.vl_types.all;
entity erase_prgm_slotrange_mux is
    port(
        slotsel         : out    vl_logic_vector(3 downto 0);
        rangesel        : out    vl_logic_vector(1 downto 0);
        erase_slot      : in     vl_logic_vector(3 downto 0);
        erase_range     : in     vl_logic_vector(1 downto 0);
        progm_slot      : in     vl_logic_vector(3 downto 0);
        progm_range     : in     vl_logic_vector(1 downto 0);
        fl_prgm_slot    : in     vl_logic_vector(3 downto 0);
        fl_prgm_range   : in     vl_logic_vector(1 downto 0);
        any_erase_iflg  : in     vl_logic;
        twi_fl_prgm_eep : in     vl_logic
    );
end erase_prgm_slotrange_mux;
