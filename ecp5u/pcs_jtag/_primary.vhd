library verilog;
use verilog.vl_types.all;
entity pcs_jtag is
    port(
        shift_dr        : in     vl_logic;
        si_jtag         : in     vl_logic;
        clock_dr_in     : in     vl_logic;
        update_dr       : in     vl_logic;
        mode_jtag       : in     vl_logic;
        rst_jtag        : in     vl_logic;
        bs4refclk       : in     vl_logic;
        bs4pad          : in     vl_logic_vector(1 downto 0);
        bs2pad          : out    vl_logic_vector(1 downto 0);
        so_jtag         : out    vl_logic;
        clock_dr_out    : out    vl_logic;
        shiftdrn_out    : out    vl_logic;
        updatedr_out    : out    vl_logic;
        mode_jtag_sd    : out    vl_logic
    );
end pcs_jtag;
