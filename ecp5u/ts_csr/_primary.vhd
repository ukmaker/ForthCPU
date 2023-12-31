library verilog;
use verilog.vl_types.all;
entity ts_csr is
    generic(
        WIDTH           : integer := 32;
        SIZE            : integer := 16;
        TCH_NUM         : integer := 3;
        ts_ave_8_const  : integer := 7;
        ts_ave_16_const : integer := 15
    );
    port(
        asc_clk         : in     vl_logic;
        ana_resetb      : in     vl_logic;
        cfg_resetb      : in     vl_logic;
        ts_ana_dig_resetb: in     vl_logic;
        ts_filter_datain: in     vl_logic_vector;
        ts_cic_data_short: in     vl_logic;
        ts_cic_data_open: in     vl_logic;
        ts_st_ch0_d     : in     vl_logic;
        ts_st_ch1_d     : in     vl_logic;
        ts_st_ch2_d     : in     vl_logic;
        ts_ld_acc_reg_from_booth: in     vl_logic;
        ts_alu_datain   : in     vl_logic_vector;
        ts_alu_q_datain : in     vl_logic_vector(16 downto 0);
        ts_alu_m_datain : in     vl_logic_vector;
        ts_alu_acc_read_data: out    vl_logic_vector;
        ts_alu_q_read_data: out    vl_logic_vector;
        ts_alu_m_read_data: out    vl_logic_vector;
        ts_ld_from_alu_x_reg: in     vl_logic;
        ts_ld_from_alu_tmeas_reg: in     vl_logic;
        ts_ld_from_alu_tmon_reg: in     vl_logic;
        ts_ld_from_alu_toffset_reg: in     vl_logic;
        ts_ld_from_alu_vbe_diff_reg: in     vl_logic;
        ts_ld_from_alu_prod_vbe_diff_reg: in     vl_logic;
        ts_rd_from_alu_m_filter_reg: in     vl_logic;
        ts_rd_from_alu_m_x_reg: in     vl_logic;
        ts_rd_from_alu_m_273: in     vl_logic;
        ts_rd_from_alu_m_trim_reg: in     vl_logic;
        ts_rd_from_alu_m_tmeas_reg: in     vl_logic;
        ts_rd_from_alu_m_toffset_reg: in     vl_logic;
        ts_rd_from_alu_m_vbe_diff_reg: in     vl_logic;
        ts_rd_from_alu_m_prod_datain: in     vl_logic;
        ts_rd_from_alu_m_acc: in     vl_logic;
        ts_rd_from_alu_acc_vbe_diff_reg: in     vl_logic;
        ts_rd_from_alu_acc_selfheat_reg: in     vl_logic;
        ts_rd_from_alu_acc_filter_reg: in     vl_logic;
        ts_rd_from_alu_acc_datain: in     vl_logic;
        ts_rd_from_alu_acc_prod_datain: in     vl_logic;
        ts_rd_from_alu_acc_x_reg: in     vl_logic;
        ts_rd_from_alu_acc_m: in     vl_logic;
        ts_rd_from_alu_acc_q: in     vl_logic;
        ts_rd_from_alu_q_filter_reg: in     vl_logic;
        ts_rd_from_alu_q_vbe_diff_reg: in     vl_logic;
        ts_rd_from_alu_q_datain: in     vl_logic;
        ts_rd_from_alu_q_ave_reg: in     vl_logic;
        ts_cfg_trim_offset_reg: in     vl_logic_vector(7 downto 0);
        ts_vol_rd       : in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_rd_from_i2c_tmeas_ch0_lo_reg: in     vl_logic;
        ts_rd_from_i2c_tmeas_ch0_hi_reg: in     vl_logic;
        ts_rd_from_i2c_tmeas_ch1_lo_reg: in     vl_logic;
        ts_rd_from_i2c_tmeas_ch1_hi_reg: in     vl_logic;
        ts_rd_from_i2c_tmeas_ch2_lo_reg: in     vl_logic;
        ts_rd_from_i2c_tmeas_ch2_hi_reg: in     vl_logic;
        ts_rd_from_i2c_tmon_a_reg: in     vl_logic;
        ts_rd_from_i2c_tmon_b_reg: in     vl_logic;
        ts_rd_from_i2c_tmon_status_reg: in     vl_logic;
        ts_cfg_rd       : in     vl_logic;
        ts_cfg_ld_data  : in     vl_logic;
        ts_cfg_tmon1_cr0_sel: in     vl_logic;
        ts_cfg_tmon1_cr1_sel: in     vl_logic;
        ts_cfg_tmon1_cr2_sel: in     vl_logic;
        ts_cfg_tmon1_cr3_sel: in     vl_logic;
        ts_cfg_tmon1_cr4_sel: in     vl_logic;
        ts_cfg_tmon1_cr5_sel: in     vl_logic;
        ts_cfg_tmon1_cr6_sel: in     vl_logic;
        ts_cfg_tmon1_cr7_sel: in     vl_logic;
        ts_cfg_tmon1_cr8_sel: in     vl_logic;
        ts_cfg_tmon2_cr0_sel: in     vl_logic;
        ts_cfg_tmon2_cr1_sel: in     vl_logic;
        ts_cfg_tmon2_cr2_sel: in     vl_logic;
        ts_cfg_tmon2_cr3_sel: in     vl_logic;
        ts_cfg_tmon2_cr4_sel: in     vl_logic;
        ts_cfg_tmon2_cr5_sel: in     vl_logic;
        ts_cfg_tmon2_cr6_sel: in     vl_logic;
        ts_cfg_tmon2_cr7_sel: in     vl_logic;
        ts_cfg_tmon2_cr8_sel: in     vl_logic;
        ts_cfg_tmonint_cr0_sel: in     vl_logic;
        ts_cfg_tmonint_cr1_sel: in     vl_logic;
        ts_cfg_tmonint_cr2_sel: in     vl_logic;
        ts_cfg_tmonint_cr3_sel: in     vl_logic;
        ts_cfg_tmonint_cr4_sel: in     vl_logic;
        ts_cfg_tmonint_cr5_sel: in     vl_logic;
        ts_cfg_tmonint_cr6_sel: in     vl_logic;
        ts_cfg_tmonint_cr7_sel: in     vl_logic;
        ts_cfg_tmonint_cr8_sel: in     vl_logic;
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_csr_dataout  : out    vl_logic_vector(7 downto 0);
        ts_channel_en_d : out    vl_logic_vector(2 downto 0);
        ts_skip_config  : out    vl_logic_vector(2 downto 0);
        ts_se_config    : out    vl_logic_vector(2 downto 0);
        ts_first_ave_flag_d: out    vl_logic_vector(2 downto 0);
        ts_pre_ave_zero : out    vl_logic;
        ts_ave_mux_data : out    vl_logic_vector(1 downto 0);
        ts_mon_data_valid: in     vl_logic;
        ts_hyst_a_neg   : out    vl_logic;
        ts_hyst_b_neg   : out    vl_logic;
        ts_ch0_a_clrtmon_ovrt: in     vl_logic;
        ts_ch1_a_clrtmon_ovrt: in     vl_logic;
        ts_ch2_a_clrtmon_ovrt: in     vl_logic;
        ts_ch0_a_setmon_ovrt: in     vl_logic;
        ts_ch1_a_setmon_ovrt: in     vl_logic;
        ts_ch2_a_setmon_ovrt: in     vl_logic;
        ts_ch0_a_cmp_ovrthres: out    vl_logic;
        ts_ch1_a_cmp_ovrthres: out    vl_logic;
        ts_ch2_a_cmp_ovrthres: out    vl_logic;
        ts_ch0_a_cmp_ovrhyst: out    vl_logic;
        ts_ch1_a_cmp_ovrhyst: out    vl_logic;
        ts_ch2_a_cmp_ovrhyst: out    vl_logic;
        ts_ch0_b_clrtmon_ovrt: in     vl_logic;
        ts_ch1_b_clrtmon_ovrt: in     vl_logic;
        ts_ch2_b_clrtmon_ovrt: in     vl_logic;
        ts_ch0_b_setmon_ovrt: in     vl_logic;
        ts_ch1_b_setmon_ovrt: in     vl_logic;
        ts_ch2_b_setmon_ovrt: in     vl_logic;
        ts_ch0_b_cmp_ovrthres: out    vl_logic;
        ts_ch1_b_cmp_ovrthres: out    vl_logic;
        ts_ch2_b_cmp_ovrthres: out    vl_logic;
        ts_ch0_b_cmp_ovrhyst: out    vl_logic;
        ts_ch1_b_cmp_ovrhyst: out    vl_logic;
        ts_ch2_b_cmp_ovrhyst: out    vl_logic;
        ts_tol_a_ch0_reg: out    vl_logic_vector(3 downto 0);
        ts_tol_b_ch0_reg: out    vl_logic_vector(3 downto 0);
        ts_tol_a_ch1_reg: out    vl_logic_vector(3 downto 0);
        ts_tol_b_ch1_reg: out    vl_logic_vector(3 downto 0);
        ts_tol_a_ch2_reg: out    vl_logic_vector(3 downto 0);
        ts_tol_b_ch2_reg: out    vl_logic_vector(3 downto 0);
        ts_tmon_a_reg   : out    vl_logic_vector;
        ts_tmon_b_reg   : out    vl_logic_vector;
        ts_ld_from_i2c_ana_tst: in     vl_logic;
        ts_ana_mfg      : out    vl_logic_vector(7 downto 0);
        ts_ld_from_i2c_digforana_tst: in     vl_logic;
        ts_force_vbe1_tst: out    vl_logic;
        ts_force_vbe2_tst: out    vl_logic;
        ts_force_vbe3_tst: out    vl_logic;
        ts_force_demratoff_tst: out    vl_logic;
        ts_force_demoutoff_tst: out    vl_logic;
        ts_force_chopoff_tst: out    vl_logic;
        ts_force_siggenoff_tst: out    vl_logic;
        ts_enable_ext_reset_tst: out    vl_logic
    );
end ts_csr;
