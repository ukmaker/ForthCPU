library verilog;
use verilog.vl_types.all;
entity read_dat is
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
        st9             : integer := 13
    );
    port(
        ld_rd_start_addr: out    vl_logic;
        reset_rd_addr_ctr: out    vl_logic;
        drv_rd_addr_mcbus: out    vl_logic;
        ld_rd_addr_latch: out    vl_logic;
        incr_rd_addr_ctr: out    vl_logic;
        runen_rd        : in     vl_logic;
        sab_rd          : in     vl_logic;
        wr_d            : in     vl_logic;
        rd_d            : in     vl_logic;
        wr_ir           : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end read_dat;
