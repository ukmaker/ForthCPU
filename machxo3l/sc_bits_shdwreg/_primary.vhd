library verilog;
use verilog.vl_types.all;
entity sc_bits_shdwreg is
    port(
        sc_bits         : out    vl_logic_vector(2 downto 0);
        sc_bits_addren  : out    vl_logic;
        mc_mcb_in       : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        cfg_load_shdwregaddrlat: in     vl_logic;
        ld_rfrsh_mshdw  : in     vl_logic;
        trim_rfrsh      : in     vl_logic
    );
end sc_bits_shdwreg;
