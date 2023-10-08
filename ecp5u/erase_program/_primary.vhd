library verilog;
use verilog.vl_types.all;
entity erase_program is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2;
        st4             : integer := 6;
        st5             : integer := 7;
        st6             : integer := 5;
        stop            : integer := 4
    );
    port(
        erase_prgrm_active: out    vl_logic;
        clear_erase_prgrm_flags: out    vl_logic;
        enable_timer    : out    vl_logic;
        en_timeout_dischrg_per: out    vl_logic;
        enable_prgrm    : out    vl_logic;
        enable_erase    : out    vl_logic;
        enable_dischrg  : out    vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        prgm_mode       : in     vl_logic;
        timer_timeout   : in     vl_logic;
        any_erase_iflg  : in     vl_logic;
        any_program_iflg: in     vl_logic;
        enable_ep       : in     vl_logic;
        force_erasprgm_st3: in     vl_logic;
        rst_erase_prgm_stmach: in     vl_logic
    );
end erase_program;
