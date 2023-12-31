library verilog;
use verilog.vl_types.all;
entity ser_tx_serializer_top is
    port(
        data_p          : out    vl_logic;
        data_n          : out    vl_logic;
        data_2d_p       : out    vl_logic;
        data_2d_n       : out    vl_logic;
        data_1d_p       : out    vl_logic;
        data_1d_n       : out    vl_logic;
        tclk_to_pcs     : out    vl_logic;
        vcctx           : inout  vl_logic;
        vsstx           : inout  vl_logic;
        vsstxs          : inout  vl_logic;
        ck_inn          : in     vl_logic;
        ck_inp          : in     vl_logic;
        div11en         : in     vl_logic;
        powdn_b         : in     vl_logic;
        sel_8bit        : in     vl_logic;
        sel_half_rate   : in     vl_logic;
        sync            : in     vl_logic;
        td_in           : in     vl_logic_vector(9 downto 0);
        pre_en          : in     vl_logic;
        post_en         : in     vl_logic;
        tx_post_sign    : in     vl_logic;
        tx_pre_sign     : in     vl_logic;
        slb_r2t_d_en    : in     vl_logic;
        slb_eq2t_en     : in     vl_logic;
        slb_r2t_ck_en   : in     vl_logic;
        eq2t_p          : in     vl_logic;
        eq2t_n          : in     vl_logic;
        t2r_dp          : out    vl_logic;
        t2r_dn          : out    vl_logic;
        ldr_core2tx_sel : in     vl_logic;
        bs_mode         : in     vl_logic;
        bs2pad          : in     vl_logic;
        slb_t2r_en      : in     vl_logic;
        ldr_core2tx     : in     vl_logic;
        r2t_p           : in     vl_logic;
        r2t_n           : in     vl_logic;
        tdrv_dat_sel    : in     vl_logic_vector(1 downto 0);
        txbitck         : out    vl_logic
    );
end ser_tx_serializer_top;
