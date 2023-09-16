library verilog;
use verilog.vl_types.all;
entity asc_eeprom_bus is
    port(
        mcbus_data      : inout  vl_logic_vector(7 downto 0);
        cfgarray_out    : out    vl_logic_vector(7 downto 0);
        i2c_out         : out    vl_logic_vector(7 downto 0);
        mc_mcb_out      : out    vl_logic_vector(7 downto 0);
        mfg_out         : out    vl_logic_vector(7 downto 0);
        readid_out      : out    vl_logic_vector(7 downto 0);
        volarray_out    : out    vl_logic_vector(7 downto 0);
        cfgarray_in     : in     vl_logic_vector(7 downto 0);
        i2c_in          : in     vl_logic_vector(7 downto 0);
        mc_mcb_in       : in     vl_logic_vector(7 downto 0);
        mfg_in          : in     vl_logic_vector(7 downto 0);
        readid_in       : in     vl_logic_vector(7 downto 0);
        volarray_in     : in     vl_logic_vector(7 downto 0);
        cfgarray_oe     : in     vl_logic;
        i2c_oe          : in     vl_logic;
        mc_mcb_oe       : in     vl_logic;
        mfg_oe          : in     vl_logic;
        readid_oe       : in     vl_logic;
        volarray_oe     : in     vl_logic;
        vddd            : inout  vl_logic;
        vssd            : inout  vl_logic
    );
end asc_eeprom_bus;
