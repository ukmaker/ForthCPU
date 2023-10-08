library verilog;
use verilog.vl_types.all;
entity wrrdvid is
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
        ldvid_shdwreg   : out    vl_logic;
        vidbyte1_sel    : out    vl_logic;
        ld_vid_allshdw_addr_latch: out    vl_logic;
        drv_vid_addr_hff_mcbus: out    vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        runen_vid       : in     vl_logic;
        wr_d            : in     vl_logic;
        rd_d            : in     vl_logic;
        wr_ir           : in     vl_logic
    );
end wrrdvid;
