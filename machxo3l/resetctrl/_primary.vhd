library verilog;
use verilog.vl_types.all;
entity resetctrl is
    port(
        clock_loss_off  : out    vl_logic;
        rst_osc_tmr_b   : out    vl_logic;
        rst_osc_b       : out    vl_logic;
        reset_b_out_pin : out    vl_logic;
        mclk            : out    vl_logic;
        rst_twi_b       : out    vl_logic;
        rst_addr_lsb_b  : out    vl_logic;
        rst_abg_b       : out    vl_logic;
        rst_vdac_b      : out    vl_logic;
        ana_rst_b       : out    vl_logic;
        reset_in_b      : out    vl_logic;
        safestate_iob   : out    vl_logic;
        ascclk_out      : out    vl_logic;
        wrclk_lost      : in     vl_logic;
        wrclk           : in     vl_logic;
        mclkout         : in     vl_logic;
        por_n           : in     vl_logic;
        ascclk_dis      : in     vl_logic;
        clklossdetect_dis: in     vl_logic;
        clksync_en      : in     vl_logic;
        safestate       : in     vl_logic;
        reset_b_in_pin  : in     vl_logic;
        eep_shdw_ready  : in     vl_logic;
        bg_cal_done     : in     vl_logic;
        dac_ready       : in     vl_logic;
        oscresetb_en    : in     vl_logic;
        i2caddr_vdac_rst_dis: in     vl_logic;
        abgrst_dis      : in     vl_logic;
        anarst_dis      : in     vl_logic;
        vdac_en         : in     vl_logic;
        vdac_reset      : in     vl_logic;
        fsafe           : in     vl_logic;
        twi_wdat_write_reg: in     vl_logic
    );
end resetctrl;
