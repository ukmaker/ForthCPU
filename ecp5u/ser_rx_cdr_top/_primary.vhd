library verilog;
use verilog.vl_types.all;
entity ser_rx_cdr_top is
    port(
        dco_status      : out    vl_logic_vector(15 downto 0);
        slb_r2t         : out    vl_logic;
        i50u4pd         : inout  vl_logic_vector(1 downto 0);
        atdcfg          : in     vl_logic_vector(1 downto 0);
        atddly          : in     vl_logic_vector(1 downto 0);
        auto_calib_enb  : in     vl_logic;
        auto_facq_enb   : in     vl_logic;
        band_threshold  : in     vl_logic_vector(5 downto 0);
        bypsatd         : in     vl_logic;
        caldiv          : in     vl_logic_vector(2 downto 0);
        calib_time_sel  : in     vl_logic_vector(1 downto 0);
        cdr_cnt4sel     : in     vl_logic_vector(1 downto 0);
        cdr_cnt8sel     : in     vl_logic_vector(1 downto 0);
        ck_core_rx      : in     vl_logic;
        calib_ck_mode   : in     vl_logic;
        reset_vcc       : in     vl_logic;
        ctlgi           : in     vl_logic_vector(2 downto 0);
        dac_bdavoid_enb : in     vl_logic;
        dco_colib_rst   : in     vl_logic;
        dco_facq_rst    : in     vl_logic;
        dcoftnrg        : in     vl_logic_vector(2 downto 0);
        dn              : in     vl_logic;
        dp              : in     vl_logic;
        dplb            : in     vl_logic;
        fc2dco_dloop    : in     vl_logic;
        flt_dac         : in     vl_logic_vector(1 downto 0);
        iostune         : in     vl_logic_vector(2 downto 0);
        itune4lsb       : in     vl_logic_vector(2 downto 0);
        itune4vco       : in     vl_logic_vector(1 downto 0);
        iupdnx2         : in     vl_logic;
        nuoflsb         : in     vl_logic_vector(2 downto 0);
        pdiadj          : in     vl_logic_vector(1 downto 0);
        dnlb            : in     vl_logic;
        rate_mode_rx    : in     vl_logic;
        reg_band_offset : in     vl_logic_vector(3 downto 0);
        reg_band_sel    : in     vl_logic_vector(5 downto 0);
        reg_idac_en     : in     vl_logic;
        reg_idac_sel    : in     vl_logic_vector(9 downto 0);
        resetb          : in     vl_logic;
        rlol            : out    vl_logic;
        rpwdnb          : in     vl_logic;
        scalei          : in     vl_logic_vector(1 downto 0);
        sel_div25       : in     vl_logic;
        sel_refckmode   : in     vl_logic_vector(1 downto 0);
        rx_dco_ck_div   : in     vl_logic_vector(2 downto 0);
        slb_r2t_clk_en  : in     vl_logic;
        slb_r2t_dat_en  : in     vl_logic;
        slb_t2r_en      : in     vl_logic;
        startval        : in     vl_logic_vector(2 downto 0);
        step            : in     vl_logic_vector(1 downto 0);
        refck_mode      : in     vl_logic_vector(1 downto 0);
        rrst_vcc        : in     vl_logic;
        lock_diff       : in     vl_logic_vector(1 downto 0);
        dco_calib_done  : out    vl_logic;
        dco_facq_done   : out    vl_logic;
        dco_facq_err    : out    vl_logic;
        dco_calib_err   : out    vl_logic;
        rx_refck_local  : in     vl_logic;
        rx_refck_sel    : in     vl_logic;
        slb_r2tb        : out    vl_logic;
        fc2dco_floop    : in     vl_logic;
        div11en_rx      : in     vl_logic;
        rlos_sel        : in     vl_logic;
        pden_sel        : in     vl_logic;
        rlos_vcc        : in     vl_logic;
        band_calib_mode : in     vl_logic;
        en_re_calib     : in     vl_logic;
        vss             : inout  vl_logic;
        vccrx           : inout  vl_logic;
        vssrxs          : inout  vl_logic;
        vssrx           : inout  vl_logic;
        vcc             : inout  vl_logic;
        i50u4dco        : inout  vl_logic_vector(1 downto 0);
        ck4des          : out    vl_logic;
        dt4des          : out    vl_logic;
        cdr_en_bitslip  : in     vl_logic;
        cdr_dlock       : in     vl_logic
    );
end ser_rx_cdr_top;
