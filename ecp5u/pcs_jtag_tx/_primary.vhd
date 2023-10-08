library verilog;
use verilog.vl_types.all;
entity pcs_jtag_tx is
    port(
        data_in         : in     vl_logic;
        data_out        : out    vl_logic;
        shift_dr        : in     vl_logic;
        si_jtag         : in     vl_logic;
        clock_dr_in     : in     vl_logic;
        update_dr       : in     vl_logic;
        mode_jtag       : in     vl_logic;
        rst_jtag        : in     vl_logic;
        so_jtag         : out    vl_logic
    );
end pcs_jtag_tx;
