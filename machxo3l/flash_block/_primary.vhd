library verilog;
use verilog.vl_types.all;
entity flash_block is
    port(
        flash_sec_prog  : out    vl_logic;
        flash_sec_read  : out    vl_logic;
        flash_secplus   : out    vl_logic;
        flash_done      : out    vl_logic;
        flash_ues       : out    vl_logic_vector(31 downto 0);
        fl_exec_buf     : out    vl_logic_vector(127 downto 0);
        fl_modal_state  : out    vl_logic_vector(31 downto 0);
        fl_pg_count     : out    vl_logic_vector(9 downto 0);
        fl_er_count     : out    vl_logic_vector(11 downto 0);
        fl_finish_ppt   : out    vl_logic;
        fl_finish_cdm   : out    vl_logic;
        fl_finish_sdm   : out    vl_logic;
        busy_flash      : out    vl_logic;
        fail_flash      : out    vl_logic;
        fail_sdm        : out    vl_logic;
        lsc_sdm         : out    vl_logic;
        sdm_start_bse   : out    vl_logic;
        sdm_bse_eof     : out    vl_logic;
        preamble_std_sdm: out    vl_logic;
        preamble_enc_sdm: out    vl_logic;
        preamble_err_sdm: out    vl_logic;
        fl_busy_ppt     : out    vl_logic;
        fl_busy_cdm     : out    vl_logic;
        fl_busy_sdm     : out    vl_logic;
        fl_load_trim    : out    vl_logic;
        fl_load_pes     : out    vl_logic;
        fl_load_mes     : out    vl_logic;
        fl_load_key     : out    vl_logic;
        fl_load_pwd     : out    vl_logic;
        fl_load_fea     : out    vl_logic;
        fl_load_feabits : out    vl_logic;
        fl_load_otps    : out    vl_logic;
        fl_erase_trim   : out    vl_logic;
        fl_erase_fea    : out    vl_logic;
        sdm_init_sram_asr_exec: out    vl_logic;
        ppt_init_tsf_asr_exec: out    vl_logic;
        ppt_write_incr_exec: out    vl_logic;
        dnld_dat        : out    vl_logic_vector(7 downto 0);
        dnld_dat_en     : out    vl_logic;
        ppt_dat         : out    vl_logic_vector(7 downto 0);
        ppt_dsr_shf8_en : out    vl_logic;
        ppt_dsr_shf     : out    vl_logic;
        ppt_en          : out    vl_logic;
        ppt_rowsel      : out    vl_logic;
        ppt_pset        : out    vl_logic;
        row             : out    vl_logic_vector(14 downto 0);
        ufm_row_sel_all : out    vl_logic;
        ufm_row_sel_none: out    vl_logic;
        cfg_row_sel_all : out    vl_logic;
        cfg_row_sel_none: out    vl_logic;
        trim_row_sel_all: out    vl_logic;
        trim_row_sel_none: out    vl_logic;
        feat_row_sel_all: out    vl_logic;
        feat_row_sel_none: out    vl_logic;
        era_ufm         : out    vl_logic;
        era_cfg         : out    vl_logic;
        era_trim        : out    vl_logic;
        era_feat        : out    vl_logic;
        prg_ufm         : out    vl_logic;
        prg_cfg         : out    vl_logic;
        prg_tf          : out    vl_logic;
        read_ufm        : out    vl_logic;
        read_cfg        : out    vl_logic;
        read_tf         : out    vl_logic;
        erase_setup     : out    vl_logic;
        erapdis         : out    vl_logic;
        erase_pulse     : out    vl_logic;
        pwtc_well       : out    vl_logic;
        prg_pulse       : out    vl_logic_vector(3 downto 0);
        prog_disch      : out    vl_logic;
        prg_pwtc        : out    vl_logic;
        en_vreg_mon     : out    vl_logic;
        era_ver         : out    vl_logic;
        scp             : out    vl_logic;
        softprg         : out    vl_logic;
        verify          : out    vl_logic;
        flash_en        : out    vl_logic;
        reg_enable      : out    vl_logic;
        scpv            : out    vl_logic;
        subrow_mvena_ufm: out    vl_logic;
        subrow_mvenall_ufm: out    vl_logic;
        subrow_hvena_ufm: out    vl_logic;
        subrow_hvenall_ufm: out    vl_logic;
        subrow_mvena_cfg: out    vl_logic;
        subrow_mvenall_cfg: out    vl_logic;
        subrow_hvena_cfg: out    vl_logic;
        subrow_hvenall_cfg: out    vl_logic;
        subrow_mvena_tf : out    vl_logic;
        subrow_hvena_tf : out    vl_logic;
        sa_enall        : out    vl_logic;
        sa_ena          : out    vl_logic;
        prgdrv_enall    : out    vl_logic;
        prgdrv_ena      : out    vl_logic;
        col_shift       : out    vl_logic;
        col_rst         : out    vl_logic;
        colstart        : out    vl_logic_vector(3 downto 0);
        readpart        : out    vl_logic_vector(3 downto 0);
        wor_eval        : out    vl_logic;
        wand_eval       : out    vl_logic;
        capture_dout    : out    vl_logic;
        src_clamp       : out    vl_logic;
        drain_ctrl      : out    vl_logic;
        sel_6p5v        : out    vl_logic;
        prestep_in_neg  : out    vl_logic_vector(2 downto 0);
        step_in_neg     : out    vl_logic_vector(2 downto 0);
        fl_ready_rst    : out    vl_logic;
        flash_clk_mfg   : out    vl_logic;
        mux32_out1      : out    vl_logic;
        mux32_out2      : out    vl_logic;
        por             : in     vl_logic;
        isc_rst_async   : in     vl_logic;
        isc_rst_sync    : in     vl_logic;
        smclk           : in     vl_logic;
        fl_smclk_mfg    : in     vl_logic;
        scanen          : in     vl_logic;
        fsafe           : in     vl_logic;
        mfg_ppt_abort   : in     vl_logic;
        mc1_ppt_bits    : in     vl_logic_vector(7 downto 0);
        isc_exec_a      : in     vl_logic;
        isc_exec_b      : in     vl_logic;
        isc_exec_c      : in     vl_logic;
        isc_exec_d      : in     vl_logic;
        isc_exec_e      : in     vl_logic;
        buf128_dat      : in     vl_logic_vector(127 downto 0);
        sector_dat      : in     vl_logic_vector(7 downto 0);
        access_flash    : in     vl_logic;
        access_tag      : in     vl_logic;
        access_mfg      : in     vl_logic;
        access_flash_all: in     vl_logic;
        access_sudo     : in     vl_logic;
        fl_start_ppt    : in     vl_logic;
        fl_start_cdm    : in     vl_logic;
        fl_start_sdm0   : in     vl_logic;
        fl_start_sdm1   : in     vl_logic;
        fl_start_sdm2   : in     vl_logic;
        fsd_gold_addr   : in     vl_logic_vector(15 downto 0);
        dev_sdm_qual    : in     vl_logic;
        busy_sram       : in     vl_logic;
        finish_bse      : in     vl_logic;
        fail_bse        : in     vl_logic;
        njbse_preamble  : in     vl_logic;
        sdm_run         : in     vl_logic;
        trim_row_ev     : in     vl_logic;
        trim_ers_pw     : in     vl_logic_vector(2 downto 0);
        trim_prg_pw     : in     vl_logic_vector(2 downto 0);
        trim_scp_pw     : in     vl_logic_vector(2 downto 0);
        trim_verify     : in     vl_logic_vector(1 downto 0);
        trim_neg_init   : in     vl_logic_vector(5 downto 0);
        trim_sel6p5v    : in     vl_logic;
        mfg_skip_era    : in     vl_logic;
        mfg_skip_ev     : in     vl_logic;
        mfg_skip_prgvfy : in     vl_logic;
        mfg_skip_scp    : in     vl_logic;
        mfg_skip_softprg: in     vl_logic;
        mfg_vreg_mon    : in     vl_logic;
        mfg_nofail      : in     vl_logic;
        mfg_dis_sel6p5v : in     vl_logic;
        mfg_fl_enable   : in     vl_logic;
        mfg_4xprg       : in     vl_logic;
        mfg_ers_cnt     : in     vl_logic_vector(3 downto 0);
        mfg_ers_perstep : in     vl_logic_vector(1 downto 0);
        mfg_ers_steps   : in     vl_logic_vector(1 downto 0);
        mfg_step_size   : in     vl_logic;
        mfg_prg_cnt     : in     vl_logic_vector(2 downto 0);
        mfg_sp_cnt      : in     vl_logic_vector(2 downto 0);
        mfg_scp_cnt     : in     vl_logic_vector(2 downto 0);
        mfg_margin_en   : in     vl_logic;
        mfg_mux1_sel    : in     vl_logic_vector(4 downto 0);
        mfg_mux2_sel    : in     vl_logic_vector(4 downto 0);
        fl_prog_ucode_qual: in     vl_logic;
        fl_erase_qual   : in     vl_logic;
        fl_prog_done_qual: in     vl_logic;
        fl_prog_sec_qual: in     vl_logic;
        fl_prog_secplus_qual: in     vl_logic;
        fl_init_addr_qual: in     vl_logic;
        fl_write_addr_qual: in     vl_logic;
        fl_prog_incr_nv_qual: in     vl_logic;
        fl_read_incr_nv_qual: in     vl_logic;
        fl_prog_password_qual: in     vl_logic;
        fl_prog_cipher_key_qual: in     vl_logic;
        fl_prog_feature_qual: in     vl_logic;
        fl_prog_feabits_qual: in     vl_logic;
        fl_prog_otps_qual: in     vl_logic;
        fl_init_addr_ufm_qual: in     vl_logic;
        fl_prog_tag_qual: in     vl_logic;
        fl_erase_tag_qual: in     vl_logic;
        fl_read_tag_qual: in     vl_logic;
        fl_prog_pes_qual: in     vl_logic;
        fl_prog_mes_qual: in     vl_logic;
        fl_prog_hes_qual: in     vl_logic;
        fl_prog_trim_qual: in     vl_logic;
        fl_read_hes_qual: in     vl_logic;
        fl_mtest_qual   : in     vl_logic;
        fea_exec_en     : in     vl_logic;
        device          : in     vl_logic_vector(2 downto 0);
        c_bl            : in     vl_logic_vector(3 downto 0);
        fl_dout         : in     vl_logic_vector(63 downto 0);
        lastcol         : in     vl_logic_vector(3 downto 0);
        fl_ready        : in     vl_logic;
        l_row_cfg       : in     vl_logic;
        l_row_ufm       : in     vl_logic;
        neg_edge_det    : in     vl_logic;
        vwlp_active     : in     vl_logic;
        ready_vfy       : in     vl_logic;
        well_active     : in     vl_logic
    );
end flash_block;