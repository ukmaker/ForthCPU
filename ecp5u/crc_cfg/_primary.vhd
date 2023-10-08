library verilog;
use verilog.vl_types.all;
entity crc_cfg is
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
        st12            : integer := 10;
        st13            : integer := 11;
        st14            : integer := 9
    );
    port(
        crcerror        : out    vl_logic;
        ld_crc_s_latch  : out    vl_logic;
        chksum_out      : out    vl_logic_vector(7 downto 0);
        mc_bus          : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        wrallrecfg_iflg : in     vl_logic;
        wr_d            : in     vl_logic;
        cfg_reset_cfgaddrregupctr: in     vl_logic;
        count_eq_crcbyteaddr: in     vl_logic;
        addrbit0        : in     vl_logic
    );
end crc_cfg;
