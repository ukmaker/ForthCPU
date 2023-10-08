library verilog;
use verilog.vl_types.all;
entity jtag_inst_dec is
    port(
        extest_i        : out    vl_logic;
        extest_pulse_i  : out    vl_logic;
        extest_train_i  : out    vl_logic;
        intest_i        : out    vl_logic;
        clamp_i         : out    vl_logic;
        highz_i         : out    vl_logic;
        sample_prld_i   : out    vl_logic;
        bypass_i        : out    vl_logic;
        verify_id_i     : out    vl_logic;
        idcode_pub_i    : out    vl_logic;
        uidcode_pub_i   : out    vl_logic;
        usercode_i      : out    vl_logic;
        read_temp_i     : out    vl_logic;
        lsc_device_ctrl_i: out    vl_logic;
        lsc_shift_password_i: out    vl_logic;
        lsc_read_status_i: out    vl_logic;
        lsc_check_busy_i: out    vl_logic;
        lsc_refresh_i   : out    vl_logic;
        lsc_bitstream_burst_i: out    vl_logic;
        lsc_i2ci_crbr_wt_i: out    vl_logic;
        lsc_i2ci_txdr_wt_i: out    vl_logic;
        lsc_i2ci_rxdr_rd_i: out    vl_logic;
        lsc_i2ci_sr_rd_i: out    vl_logic;
        ip_a_i          : out    vl_logic;
        ip_b_i          : out    vl_logic;
        iptest_a_i      : out    vl_logic;
        iptest_b_i      : out    vl_logic;
        lsc_prog_spi_i  : out    vl_logic;
        idcode_prv_i    : out    vl_logic;
        read_pes_i      : out    vl_logic;
        mfg_shift_i     : out    vl_logic;
        isc_enable_i    : out    vl_logic;
        isc_enable_x_i  : out    vl_logic;
        isc_disable_i   : out    vl_logic;
        isc_program_i   : out    vl_logic;
        isc_noop_i      : out    vl_logic;
        isc_prog_ucode_i: out    vl_logic;
        isc_read_i      : out    vl_logic;
        isc_erase_i     : out    vl_logic;
        isc_discharge_i : out    vl_logic;
        isc_prog_done_i : out    vl_logic;
        isc_erase_done_i: out    vl_logic;
        isc_prog_sec_i  : out    vl_logic;
        isc_prog_secplus_i: out    vl_logic;
        isc_data_shift_i: out    vl_logic;
        isc_addr_shift_i: out    vl_logic;
        lsc_init_addr_i : out    vl_logic;
        lsc_write_addr_i: out    vl_logic;
        lsc_prog_incr_rti_i: out    vl_logic;
        lsc_prog_incr_enc_i: out    vl_logic;
        lsc_prog_incr_cmp_i: out    vl_logic;
        lsc_prog_incr_cne_i: out    vl_logic;
        lsc_vfy_incr_rti_i: out    vl_logic;
        lsc_prog_ctrl0_i: out    vl_logic;
        lsc_read_ctrl0_i: out    vl_logic;
        lsc_reset_crc_i : out    vl_logic;
        lsc_read_crc_i  : out    vl_logic;
        lsc_prog_sed_crc_i: out    vl_logic;
        lsc_read_sed_crc_i: out    vl_logic;
        lsc_prog_password_i: out    vl_logic;
        lsc_read_password_i: out    vl_logic;
        lsc_prog_cipher_key_i: out    vl_logic;
        lsc_read_cipher_key_i: out    vl_logic;
        lsc_prog_feature_i: out    vl_logic;
        lsc_read_feature_i: out    vl_logic;
        lsc_prog_feabits_i: out    vl_logic;
        lsc_read_feabits_i: out    vl_logic;
        lsc_prog_otps_i : out    vl_logic;
        lsc_read_otps_i : out    vl_logic;
        lsc_write_comp_dic_i: out    vl_logic;
        lsc_write_bus_addr_i: out    vl_logic;
        lsc_pcs_write_i : out    vl_logic;
        lsc_pcs_read_i  : out    vl_logic;
        lsc_ebr_write_i : out    vl_logic;
        lsc_ebr_read_i  : out    vl_logic;
        lsc_prog_incr_nv_i: out    vl_logic;
        lsc_read_incr_nv_i: out    vl_logic;
        lsc_init_addr_ufm_i: out    vl_logic;
        lsc_prog_tag_i  : out    vl_logic;
        lsc_erase_tag_i : out    vl_logic;
        lsc_read_tag_i  : out    vl_logic;
        lsc_prog_pes_i  : out    vl_logic;
        lsc_mtest_i     : out    vl_logic;
        lsc_mtrim_i     : out    vl_logic;
        lsc_mdata_i     : out    vl_logic;
        lsc_iscan_i     : out    vl_logic;
        instruction     : in     vl_logic_vector(7 downto 0)
    );
end jtag_inst_dec;
