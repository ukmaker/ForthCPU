library verilog;
use verilog.vl_types.all;
entity trimcfgrefresh_ldshdw is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2;
        st4             : integer := 6;
        st5             : integer := 7;
        st6             : integer := 5;
        st7             : integer := 4;
        st8             : integer := 12;
        st9             : integer := 13;
        st10            : integer := 15;
        st11            : integer := 14;
        st12            : integer := 10
    );
    port(
        refresh_on      : out    vl_logic;
        reset_rfrsh_addr_ctr: out    vl_logic;
        drv_rfrsh_addr_mcbus: out    vl_logic;
        ld_rfrsh_addr_latch: out    vl_logic;
        trim_rfrsh      : out    vl_logic;
        drive_rfrsh_data_mcbus: out    vl_logic;
        ld_rfrsh_mshdw  : out    vl_logic;
        incr_rfrsh_addr_ctr: out    vl_logic;
        ld_rfrsh_sshdw  : out    vl_logic;
        rst_ldshdw_iflgs: out    vl_logic;
        porsync         : in     vl_logic;
        ldshdw_iflg     : in     vl_logic;
        count_eq_maxcfgaddr: in     vl_logic;
        ldtrimshdw_iflg : in     vl_logic;
        count_eq_maxtrimaddr: in     vl_logic;
        clk             : in     vl_logic
    );
end trimcfgrefresh_ldshdw;
