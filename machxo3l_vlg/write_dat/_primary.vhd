library verilog;
use verilog.vl_types.all;
entity write_dat is
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
        st11            : integer := 14
    );
    port(
        ld_wr_start_addr: out    vl_logic;
        reset_wr_addr_ctr: out    vl_logic;
        drv_wr_addr_mcbus: out    vl_logic;
        ld_wr_addr_latch: out    vl_logic;
        incr_wr_addr_ctr: out    vl_logic;
        ld_wr_data_reg  : out    vl_logic;
        runen_wr        : in     vl_logic;
        sab_wr          : in     vl_logic;
        wr_d            : in     vl_logic;
        wr_ir           : in     vl_logic;
        rd_d            : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end write_dat;
