library verilog;
use verilog.vl_types.all;
entity pp_fc_sync is
    generic(
        STATE_A         : integer := 0;
        STATE_B1        : integer := 1;
        STATE_B2        : integer := 2;
        STATE_B2A       : integer := 3;
        STATE_B3        : integer := 4;
        STATE_B3A       : integer := 5;
        STATE_B4        : integer := 6;
        STATE_B4A       : integer := 7
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        signal_detect   : in     vl_logic;
        k_ctrl          : in     vl_logic;
        comma_detect    : in     vl_logic;
        code_violation  : in     vl_logic;
        sync_status     : out    vl_logic;
        enable_cgalign  : out    vl_logic
    );
end pp_fc_sync;
