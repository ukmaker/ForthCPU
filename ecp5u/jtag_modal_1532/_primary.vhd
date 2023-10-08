library verilog;
use verilog.vl_types.all;
entity jtag_modal_1532 is
    port(
        isc_test_mode   : out    vl_logic;
        isc_enabled     : out    vl_logic;
        isc_disable_completing: out    vl_logic;
        por             : in     vl_logic;
        tck             : in     vl_logic;
        tlreset         : in     vl_logic;
        upir_ss         : in     vl_logic;
        ir_sr           : in     vl_logic_vector(7 downto 0);
        isc_disable_i   : in     vl_logic;
        j_enable_qual   : in     vl_logic;
        j_enable_x_qual : in     vl_logic;
        j_disable_qual  : in     vl_logic;
        test_mode_i     : in     vl_logic;
        non_test_mode_i : in     vl_logic
    );
end jtag_modal_1532;
