library verilog;
use verilog.vl_types.all;
entity njtag_modal is
    port(
        isc_nj_enabled  : out    vl_logic;
        isc_nj_disable_completing: out    vl_logic;
        smclk           : in     vl_logic;
        nj_rst_async    : in     vl_logic;
        nj_rst_sync0    : in     vl_logic;
        scanen          : in     vl_logic;
        njcommand       : in     vl_logic_vector(7 downto 0);
        nj_enable_qual  : in     vl_logic;
        nj_enable_x_qual: in     vl_logic;
        nj_disable_qual : in     vl_logic;
        isc_disable_c   : in     vl_logic;
        ref_launch      : in     vl_logic;
        ref_exit        : in     vl_logic
    );
end njtag_modal;
