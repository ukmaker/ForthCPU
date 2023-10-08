library verilog;
use verilog.vl_types.all;
entity pp_rio_ls is
    generic(
        NO_SYNC         : integer := 0;
        NO_SYNC_2       : integer := 1;
        SYNC            : integer := 2;
        SYNC_2          : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        signal_detect   : in     vl_logic;
        comma_detect    : in     vl_logic;
        code_violation  : in     vl_logic;
        enable_cgalign  : out    vl_logic;
        lane_sync       : out    vl_logic
    );
end pp_rio_ls;
