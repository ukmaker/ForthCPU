library verilog;
use verilog.vl_types.all;
entity ser_aux_misc is
    port(
        aux_spare_inbo  : out    vl_logic_vector(7 downto 0);
        bitclk_from_nd_eno: out    vl_logic;
        bitclk_local_eno: out    vl_logic;
        bitclk_nd_eno   : out    vl_logic;
        bs4refck        : out    vl_logic;
        bus8bit_selo    : out    vl_logic;
        cdr_lol_setvcc  : out    vl_logic_vector(1 downto 0);
        ck_core_txo     : out    vl_logic;
        ck_fbvcc        : out    vl_logic;
        cmusetibiaso    : out    vl_logic_vector(1 downto 0);
        dcotcalib_selvcc: out    vl_logic_vector(1 downto 0);
        irefpwdnb       : out    vl_logic;
        isetloso        : out    vl_logic_vector(7 downto 0);
        macropdbo       : out    vl_logic;
        macropdbvcc     : out    vl_logic;
        pd_iseto        : out    vl_logic_vector(1 downto 0);
        pll_lol_div_vcc : out    vl_logic_vector(1 downto 0);
        plol_sts        : out    vl_logic;
        plol_stsb       : out    vl_logic;
        refck2core      : out    vl_logic;
        refck4nd_selo   : out    vl_logic_vector(1 downto 0);
        refck25xo       : out    vl_logic;
        refck_dcbias_eno: out    vl_logic;
        refck_modeo     : out    vl_logic_vector(1 downto 0);
        refck_modevcc   : out    vl_logic_vector(1 downto 0);
        refck_out_selo  : out    vl_logic_vector(1 downto 0);
        refck_rtermo    : out    vl_logic;
        refck_to_nd_eno : out    vl_logic;
        refck_txvcc     : out    vl_logic;
        refckpwdnb      : out    vl_logic;
        reg2fpga_ctrlo  : out    vl_logic;
        req_iseto       : out    vl_logic_vector(2 downto 0);
        reset_vcc       : out    vl_logic;
        reseto          : out    vl_logic;
        rg_eno          : out    vl_logic;
        rg_seto         : out    vl_logic_vector(1 downto 0);
        rx_bs_modeo     : out    vl_logic;
        rx_refck_local  : out    vl_logic;
        ser_memo        : out    vl_logic_vector(41 downto 8);
        seticonst_auxo  : out    vl_logic_vector(1 downto 0);
        seticonst_cho   : out    vl_logic_vector(1 downto 0);
        setirpoly_auxo  : out    vl_logic_vector(1 downto 0);
        setirpoly_cho   : out    vl_logic_vector(1 downto 0);
        setpllrco       : out    vl_logic_vector(5 downto 0);
        sync_local_eno  : out    vl_logic;
        sync_nd_eno     : out    vl_logic;
        sync_pulseo     : out    vl_logic;
        tck_full        : out    vl_logic;
        tielow_aux      : out    vl_logic;
        trsto           : out    vl_logic;
        tst_eno         : out    vl_logic;
        tst_selo        : out    vl_logic_vector(3 downto 0);
        tx_bs_modeo     : out    vl_logic;
        tx_refck_selo   : out    vl_logic;
        tx_vco_ck_divo  : out    vl_logic_vector(2 downto 0);
        txpllpwdnb      : out    vl_logic;
        zero            : out    vl_logic_vector(7 downto 0);
        vcc             : inout  vl_logic;
        vcca            : inout  vl_logic;
        vss             : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        aux_spare_inb   : in     vl_logic_vector(7 downto 0);
        bitclk_from_nd_en: in     vl_logic;
        bitclk_local_en : in     vl_logic;
        bitclk_nd_en    : in     vl_logic;
        bs4refckin      : in     vl_logic;
        bus8bit_sel     : in     vl_logic;
        cdr_lol_set     : in     vl_logic_vector(1 downto 0);
        ck_core_tx      : in     vl_logic;
        ck_fb           : in     vl_logic;
        cmusetbiasi     : in     vl_logic_vector(1 downto 0);
        dcotcalib_sel   : in     vl_logic_vector(1 downto 0);
        ib_pwdnb        : in     vl_logic;
        isetlos         : in     vl_logic_vector(7 downto 0);
        macropdb        : in     vl_logic;
        macrorst        : in     vl_logic;
        pd_iset         : in     vl_logic_vector(1 downto 0);
        pll_lol_div     : in     vl_logic_vector(1 downto 0);
        plol            : in     vl_logic;
        pwr_on_rst      : in     vl_logic;
        refck2corein    : in     vl_logic;
        refck4nd_sel    : in     vl_logic_vector(1 downto 0);
        refck25x        : in     vl_logic;
        refck_dcbias_en : in     vl_logic;
        refck_mode      : in     vl_logic_vector(1 downto 0);
        refck_out_sel   : in     vl_logic_vector(1 downto 0);
        refck_pwdnb     : in     vl_logic;
        refck_rterm     : in     vl_logic;
        refck_to_nd_en  : in     vl_logic;
        refck_tx        : in     vl_logic;
        reg2fpga_ctrl   : in     vl_logic;
        req_iset        : in     vl_logic_vector(2 downto 0);
        rg_en           : in     vl_logic;
        rg_set          : in     vl_logic_vector(1 downto 0);
        rx_bs_mode      : in     vl_logic;
        rx_refck_localin: in     vl_logic;
        ser_mem         : in     vl_logic_vector(41 downto 8);
        seticonst_aux   : in     vl_logic_vector(1 downto 0);
        seticonst_ch    : in     vl_logic_vector(1 downto 0);
        setirpoly_aux   : in     vl_logic_vector(1 downto 0);
        setirpoly_ch    : in     vl_logic_vector(1 downto 0);
        setpllrc        : in     vl_logic_vector(5 downto 0);
        sync_local_en   : in     vl_logic;
        sync_nd_en      : in     vl_logic;
        sync_pulse      : in     vl_logic;
        tck_fullin      : in     vl_logic;
        trst            : in     vl_logic;
        tst_en          : in     vl_logic;
        tst_sel         : in     vl_logic_vector(3 downto 0);
        tx_bs_mode      : in     vl_logic;
        tx_refck_sel    : in     vl_logic;
        tx_vco_ck_div   : in     vl_logic_vector(2 downto 0);
        txpll_pwdnb     : in     vl_logic
    );
end ser_aux_misc;