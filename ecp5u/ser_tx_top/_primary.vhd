library verilog;
use verilog.vl_types.all;
entity ser_tx_top is
    port(
        hdoutn          : out    vl_logic;
        hdoutp          : out    vl_logic;
        pci_connect     : out    vl_logic;
        pci_det_done    : out    vl_logic;
        t2r_dn          : out    vl_logic;
        t2r_dp          : out    vl_logic;
        tck             : out    vl_logic;
        vcca25          : inout  vl_logic;
        vcchtx          : inout  vl_logic;
        vcctx           : inout  vl_logic;
        vss_esd         : inout  vl_logic;
        vsstx           : inout  vl_logic;
        vsstxs          : inout  vl_logic;
        bs2pad          : in     vl_logic;
        ck_inn          : in     vl_logic;
        ck_inp          : in     vl_logic;
        eq2t_n          : in     vl_logic;
        eq2t_p          : in     vl_logic;
        i50ucons        : in     vl_logic_vector(2 downto 0);
        i50ures         : in     vl_logic;
        ldr_core2tx     : in     vl_logic;
        ldr_core2tx_sel : in     vl_logic;
        pci_det_ct      : in     vl_logic;
        pci_det_en      : in     vl_logic;
        pci_ei_en       : in     vl_logic;
        pcie_mode       : in     vl_logic;
        r2t_n           : in     vl_logic;
        r2t_p           : in     vl_logic;
        rate_mode_tx    : in     vl_logic;
        rterm_tx        : in     vl_logic_vector(3 downto 0);
        sel_8bit        : in     vl_logic;
        slb_eq2t_en     : in     vl_logic;
        slb_r2t_ck_en   : in     vl_logic;
        slb_r2t_d_en    : in     vl_logic;
        slb_t2r_en      : in     vl_logic;
        sync            : in     vl_logic;
        td              : in     vl_logic_vector(9 downto 0);
        tdrv_dat_sel    : in     vl_logic_vector(1 downto 0);
        tdrv_post_en    : in     vl_logic;
        tdrv_pre_en     : in     vl_logic;
        tpwdnb          : in     vl_logic;
        tx_bs_mode      : in     vl_logic;
        tx_cm_sel       : in     vl_logic_vector(1 downto 0);
        tx_div11_sel    : in     vl_logic;
        tx_post_sign    : in     vl_logic;
        tx_pre_sign     : in     vl_logic;
        tx_slice0_cur   : in     vl_logic_vector(2 downto 0);
        tx_slice0_sel   : in     vl_logic_vector(1 downto 0);
        tx_slice1_cur   : in     vl_logic_vector(2 downto 0);
        tx_slice1_sel   : in     vl_logic_vector(1 downto 0);
        tx_slice2_cur   : in     vl_logic_vector(1 downto 0);
        tx_slice2_sel   : in     vl_logic_vector(1 downto 0);
        tx_slice3_cur   : in     vl_logic_vector(1 downto 0);
        tx_slice3_sel   : in     vl_logic_vector(1 downto 0);
        tx_slice4_cur   : in     vl_logic;
        tx_slice4_sel   : in     vl_logic_vector(1 downto 0);
        tx_slice5_cur   : in     vl_logic;
        tx_slice5_sel   : in     vl_logic_vector(1 downto 0)
    );
end ser_tx_top;
