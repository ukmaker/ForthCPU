library verilog;
use verilog.vl_types.all;
entity flash_top is
    port(
        fl_c_bl         : out    vl_logic_vector(3 downto 0);
        fl_dout         : out    vl_logic_vector(63 downto 0);
        fl_lastcol      : out    vl_logic_vector(3 downto 0);
        fl_neg_edge_det : out    vl_logic;
        fl_ready_vfy    : out    vl_logic;
        fl_vwlp_active  : out    vl_logic;
        fl_well_active  : out    vl_logic;
        fl_ready        : out    vl_logic;
        fl_l_row_cfg    : out    vl_logic;
        fl_l_row_ufm    : out    vl_logic;
        fl_mfg_bits     : in     vl_logic_vector(7 downto 0);
        fl_trim_bits    : in     vl_logic_vector(16 downto 0);
        fl_row          : in     vl_logic_vector(14 downto 0);
        fl_ufm_row_sel_all: in     vl_logic;
        fl_ufm_row_sel_none: in     vl_logic;
        fl_cfg_row_sel_all: in     vl_logic;
        fl_cfg_row_sel_none: in     vl_logic;
        fl_trim_row_sel_all: in     vl_logic;
        fl_trim_row_sel_none: in     vl_logic;
        fl_feat_row_sel_all: in     vl_logic;
        fl_feat_row_sel_none: in     vl_logic;
        fl_era_ufm      : in     vl_logic;
        fl_era_cfg      : in     vl_logic;
        fl_era_trim     : in     vl_logic;
        fl_era_feat     : in     vl_logic;
        fl_prg_ufm      : in     vl_logic;
        fl_prg_cfg      : in     vl_logic;
        fl_prg_tf       : in     vl_logic;
        fl_read_ufm     : in     vl_logic;
        fl_read_cfg     : in     vl_logic;
        fl_read_tf      : in     vl_logic;
        fl_erase_setup  : in     vl_logic;
        fl_erapdis      : in     vl_logic;
        fl_erase_pulse  : in     vl_logic;
        fl_pwtc_well    : in     vl_logic;
        fl_prg_pulse    : in     vl_logic_vector(3 downto 0);
        fl_prog_disch   : in     vl_logic;
        fl_prg_pwtc     : in     vl_logic;
        fl_en_vreg_mon  : in     vl_logic;
        fl_era_ver      : in     vl_logic;
        fl_scp          : in     vl_logic;
        fl_softprg      : in     vl_logic;
        fl_verify       : in     vl_logic;
        fl_flash_en     : in     vl_logic;
        fl_reg_enable   : in     vl_logic;
        fl_subrow_mvena_ufm: in     vl_logic;
        fl_subrow_mvenall_ufm: in     vl_logic;
        fl_subrow_hvena_ufm: in     vl_logic;
        fl_subrow_hvenall_ufm: in     vl_logic;
        fl_subrow_mvena_cfg: in     vl_logic;
        fl_subrow_mvenall_cfg: in     vl_logic;
        fl_subrow_hvena_cfg: in     vl_logic;
        fl_subrow_hvenall_cfg: in     vl_logic;
        fl_subrow_mvena_tf: in     vl_logic;
        fl_subrow_hvena_tf: in     vl_logic;
        fl_sa_enall     : in     vl_logic;
        fl_sa_ena       : in     vl_logic;
        fl_prgdrv_enall : in     vl_logic;
        fl_prgdrv_ena   : in     vl_logic;
        fl_col_shift    : in     vl_logic;
        fl_colstart     : in     vl_logic_vector(3 downto 0);
        fl_col_rst      : in     vl_logic;
        fl_readpart     : in     vl_logic_vector(3 downto 0);
        fl_wor_eval     : in     vl_logic;
        fl_wand_eval    : in     vl_logic;
        fl_capture_dout : in     vl_logic;
        fl_src_clamp    : in     vl_logic;
        fl_scpv         : in     vl_logic;
        fl_drain_ctrl   : in     vl_logic;
        fl_sel_6p5v     : in     vl_logic;
        fl_prestep_in_neg: in     vl_logic_vector(2 downto 0);
        fl_step_in_neg  : in     vl_logic_vector(2 downto 0);
        fl_ppt_en       : in     vl_logic;
        fl_ppt_pset     : in     vl_logic;
        fl_ppt_rowsel   : in     vl_logic;
        fl_ready_rst    : in     vl_logic;
        fl_mfg_margin_en: in     vl_logic;
        flash_clk_mfg   : in     vl_logic;
        mux32_out1_mfg  : in     vl_logic;
        mux32_out2_mfg  : in     vl_logic;
        fl_por_init_n   : in     vl_logic
    );
end flash_top;