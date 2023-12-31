library verilog;
use verilog.vl_types.all;
entity njtag_cntl is
    generic(
        FLASH_MEM       : integer := 1;
        EFUSE_MEM       : integer := 1;
        DECRYPTION      : integer := 1
    );
    port(
        njcom_out       : out    vl_logic_vector(7 downto 0);
        nj_rcv_rd_cmd   : out    vl_logic;
        njburst_inp     : out    vl_logic;
        njs_halt        : out    vl_logic;
        njconfig_dat    : out    vl_logic_vector(3 downto 0);
        njsector_dat    : out    vl_logic_vector(7 downto 0);
        njbuf128_dat    : out    vl_logic_vector(127 downto 0);
        nj_check_crc    : out    vl_logic;
        njpcs_addr_dat  : out    vl_logic_vector(14 downto 0);
        isc_data_shift_cq: out    vl_logic;
        isc_addr_shift_cq: out    vl_logic;
        verify_id_cq    : out    vl_logic;
        idcode_pub_cq   : out    vl_logic;
        uidcode_pub_cq  : out    vl_logic;
        usercode_cq     : out    vl_logic;
        read_temp_cq    : out    vl_logic;
        lsc_device_ctrl_cq: out    vl_logic;
        lsc_shift_password_cq: out    vl_logic;
        lsc_read_status_cq: out    vl_logic;
        lsc_check_busy_cq: out    vl_logic;
        lsc_refresh_cq  : out    vl_logic;
        lsc_bitstream_burst_cq: out    vl_logic;
        idcode_prv_cq   : out    vl_logic;
        lsc_read_pes_cq : out    vl_logic;
        lsc_prog_ctrl0_cq: out    vl_logic;
        lsc_read_ctrl0_cq: out    vl_logic;
        lsc_reset_crc_cq: out    vl_logic;
        lsc_read_crc_cq : out    vl_logic;
        lsc_write_comp_dic_cq: out    vl_logic;
        sf_prog_ucode_cq: out    vl_logic;
        sf_program_cq   : out    vl_logic;
        sf_read_cq      : out    vl_logic;
        sf_erase_cq     : out    vl_logic;
        sf_prog_done_cq : out    vl_logic;
        sf_erase_done_cq: out    vl_logic;
        sf_prog_sec_cq  : out    vl_logic;
        sf_init_addr_cq : out    vl_logic;
        sf_write_addr_cq: out    vl_logic;
        sf_prog_incr_rti_cq: out    vl_logic;
        sf_prog_incr_enc_cq: out    vl_logic;
        sf_prog_incr_cmp_cq: out    vl_logic;
        sf_prog_incr_cne_cq: out    vl_logic;
        sf_vfy_incr_rti_cq: out    vl_logic;
        sf_prog_sed_crc_cq: out    vl_logic;
        sf_read_sed_crc_cq: out    vl_logic;
        sf_write_bus_addr_cq: out    vl_logic;
        sf_pcs_write_cq : out    vl_logic;
        sf_pcs_read_cq  : out    vl_logic;
        sf_ebr_write_cq : out    vl_logic;
        sf_ebr_read_cq  : out    vl_logic;
        fl_prog_ucode_cq: out    vl_logic;
        fl_erase_cq     : out    vl_logic;
        fl_prog_done_cq : out    vl_logic;
        fl_prog_sec_cq  : out    vl_logic;
        fl_prog_secplus_cq: out    vl_logic;
        fl_init_addr_cq : out    vl_logic;
        fl_write_addr_cq: out    vl_logic;
        fl_prog_incr_nv_cq: out    vl_logic;
        fl_read_incr_nv_cq: out    vl_logic;
        fl_prog_password_cq: out    vl_logic;
        fl_read_password_cq: out    vl_logic;
        fl_prog_cipher_key_cq: out    vl_logic;
        fl_read_cipher_key_cq: out    vl_logic;
        fl_prog_feature_cq: out    vl_logic;
        fl_read_feature_cq: out    vl_logic;
        fl_prog_feabits_cq: out    vl_logic;
        fl_read_feabits_cq: out    vl_logic;
        fl_prog_otps_cq : out    vl_logic;
        fl_read_otps_cq : out    vl_logic;
        fl_init_addr_ufm_cq: out    vl_logic;
        fl_prog_tag_cq  : out    vl_logic;
        fl_erase_tag_cq : out    vl_logic;
        fl_read_tag_cq  : out    vl_logic;
        ef_init_addr_cq : out    vl_logic;
        ef_write_addr_cq: out    vl_logic;
        ef_prog_password_cq: out    vl_logic;
        ef_read_password_cq: out    vl_logic;
        ef_prog_cipher_key_cq: out    vl_logic;
        ef_read_cipher_key_cq: out    vl_logic;
        ef_prog_feature_cq: out    vl_logic;
        ef_read_feature_cq: out    vl_logic;
        ef_prog_feabits_cq: out    vl_logic;
        ef_read_feabits_cq: out    vl_logic;
        ef_prog_otps_cq : out    vl_logic;
        ef_read_otps_cq : out    vl_logic;
        lsc_jump_cq     : out    vl_logic;
        lsc_chip_select_cq: out    vl_logic;
        lsc_flow_through_cq: out    vl_logic;
        bypass_cq       : out    vl_logic;
        sed_init_addr_cq: out    vl_logic;
        sed_write_addr_cq: out    vl_logic;
        sed_prog_incr_rti_cq: out    vl_logic;
        sed_prog_incr_cmp_cq: out    vl_logic;
        sed_prog_sed_crc_cq: out    vl_logic;
        sed_prog_ctrl0_cq: out    vl_logic;
        sed_write_comp_dic_cq: out    vl_logic;
        lsc_i2ci_crbr_wt_cq: out    vl_logic;
        lsc_i2ci_txdr_wt_cq: out    vl_logic;
        lsc_i2ci_rxdr_rd_cq: out    vl_logic;
        lsc_i2ci_sr_rd_cq: out    vl_logic;
        njtag_active    : out    vl_logic;
        njtag_active_nsed: out    vl_logic;
        nj_frame_end    : out    vl_logic;
        njtag_cmd       : out    vl_logic;
        njtag_infa      : out    vl_logic;
        njshf_dat0      : out    vl_logic;
        njshf_dat       : out    vl_logic;
        njshf_crc       : out    vl_logic;
        njshf_dum       : out    vl_logic;
        njshf_dat_nd    : out    vl_logic;
        isc_nj_enabled  : out    vl_logic;
        isc_nj_disable_completing: out    vl_logic;
        njaccess_sram   : out    vl_logic;
        njaccess_flash  : out    vl_logic;
        njaccess_fl_norm: out    vl_logic;
        njaccess_fl_sudo: out    vl_logic;
        njaccess_fl_safe: out    vl_logic;
        njaccess_efuse  : out    vl_logic;
        njaccess_ef_norm: out    vl_logic;
        njaccess_ef_sudo: out    vl_logic;
        njaccess_ef_safe: out    vl_logic;
        njaccess_tag    : out    vl_logic;
        njaccess_flash_all: out    vl_logic;
        nj_enable_qual  : out    vl_logic;
        nj_enable_x_qual: out    vl_logic;
        nj_disable_qual : out    vl_logic;
        njenable_offl   : out    vl_logic;
        njrst_isc_done_c: out    vl_logic;
        njset_isc_done_c: out    vl_logic;
        bse_end_cqual   : out    vl_logic;
        nj_exec_a       : out    vl_logic;
        nj_exec_b       : out    vl_logic;
        nj_exec_c       : out    vl_logic;
        nj_exec_d       : out    vl_logic;
        nj_exec_e       : out    vl_logic;
        nj_exec_f       : out    vl_logic;
        njexit_fl_offline: out    vl_logic;
        njexit_normal   : out    vl_logic;
        njm_invalid_c   : out    vl_logic;
        njr_invalid_c   : out    vl_logic;
        njs_invalid_c   : out    vl_logic;
        sed_invalid_c   : out    vl_logic;
        njtag_slv_en    : out    vl_logic;
        nj_cmd_read_com : out    vl_logic;
        nj_cmd_read_dsr : out    vl_logic;
        nj_cmd_prog_com : out    vl_logic;
        njfsm_hold      : out    vl_logic;
        dum_dat         : out    vl_logic_vector(7 downto 0);
        cmd_dsr_1byte   : out    vl_logic;
        nj_dsr_shf      : out    vl_logic;
        nj_dsr_data     : out    vl_logic_vector(7 downto 0);
        nj_jump_param   : out    vl_logic_vector(31 downto 0);
        nj_csel_param   : out    vl_logic_vector(7 downto 0);
        njvfy_rst_exec  : out    vl_logic;
        njpspi_en_norm  : out    vl_logic;
        njpspi_en_stack : out    vl_logic;
        njpspi_en_int   : out    vl_logic;
        njpspi_param    : out    vl_logic_vector(7 downto 0);
        decom_last_mask : out    vl_logic;
        NDUM_DEFAULT    : in     vl_logic_vector(3 downto 0);
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        nj_rst_async    : in     vl_logic;
        nj_rst_sync0    : in     vl_logic;
        nj_rst_sync     : in     vl_logic;
        DSR_LENGTH      : in     vl_logic_vector(15 downto 0);
        scanen          : in     vl_logic;
        jtag_active_smsync: in     vl_logic;
        isc_done        : in     vl_logic;
        nj_com_word4_dat: in     vl_logic_vector(127 downto 0);
        jburst_inp      : in     vl_logic;
        dev_sdm_inp     : in     vl_logic;
        busy_int        : in     vl_logic;
        ref_launch      : in     vl_logic;
        ref_exit        : in     vl_logic;
        njbse_rxcmd     : in     vl_logic;
        njbse_rxdec     : in     vl_logic;
        finish_bse      : in     vl_logic;
        sed_boot        : in     vl_logic;
        sed_en_adv      : in     vl_logic;
        sed_active      : in     vl_logic;
        cfg_mstr_busy   : in     vl_logic;
        p_scm           : in     vl_logic;
        p_scpu          : in     vl_logic;
        njport_init     : in     vl_logic;
        njport_active   : in     vl_logic;
        njport_exec     : in     vl_logic;
        njtag_run       : in     vl_logic;
        njtag_din       : in     vl_logic_vector(7 downto 0);
        dsr_cnt_en      : in     vl_logic;
        decompress_njtag_en: in     vl_logic;
        dec_load        : in     vl_logic;
        nj_dat_ren      : in     vl_logic;
        nj_dat_wen      : in     vl_logic;
        ctrl_wkup_tran  : in     vl_logic;
        ctrl_tran_edit  : in     vl_logic;
        ctrl_srme       : in     vl_logic;
        ctrl_stx_dum    : in     vl_logic_vector(1 downto 0)
    );
end njtag_cntl;
