library verilog;
use verilog.vl_types.all;
entity pp_link_sync is
    generic(
        LOSS_OF_SYNC    : integer := 0;
        COMMA_DET_1     : integer := 1;
        ACQUIRE_SYNC_1  : integer := 2;
        COMMA_DET_2     : integer := 3;
        ACQUIRE_SYNC_2  : integer := 4;
        COMMA_DET_3     : integer := 5;
        SYNC_ACQUIRED_1 : integer := 6;
        SYNC_ACQUIRED_2 : integer := 7;
        SYNC_ACQUIRED_2A: integer := 8;
        SYNC_ACQUIRED_3 : integer := 9;
        SYNC_ACQUIRED_3A: integer := 10;
        SYNC_ACQUIRED_4 : integer := 11;
        SYNC_ACQUIRED_4A: integer := 12
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        mode            : in     vl_logic;
        signal_detect   : in     vl_logic;
        mr_loopback     : in     vl_logic;
        k_ctrl          : in     vl_logic;
        comma_detect    : in     vl_logic;
        code_violation  : in     vl_logic;
        sync_status     : out    vl_logic;
        rx_even         : out    vl_logic;
        enable_cgalign  : out    vl_logic
    );
end pp_link_sync;
