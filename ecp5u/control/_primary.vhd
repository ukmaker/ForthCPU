library verilog;
use verilog.vl_types.all;
entity control is
    port(
        en_i2c_dat      : out    vl_logic;
        sab_wr          : out    vl_logic;
        runen_wr        : out    vl_logic;
        sab_rd          : out    vl_logic;
        runen_rd        : out    vl_logic;
        runen_rmw       : out    vl_logic;
        runen_vid       : out    vl_logic;
        cfg_reset_cfgaddrregupctr: out    vl_logic;
        cfg_load_cfgaddrregupctr: out    vl_logic;
        cfg_incr_cfgaddrregupctr: out    vl_logic;
        cfgaddrregupctr_drvmcbus: out    vl_logic;
        cfgtrim_load_addrlat: out    vl_logic;
        cfg_load_shdwregaddrlat: out    vl_logic;
        cfgshdw_ld_m_latch: out    vl_logic;
        cfgshdw_ld_m_latch_iawp: out    vl_logic;
        cfgshdw_ld_s_latch: out    vl_logic;
        cfgmshdw_drvmcbus: out    vl_logic;
        cfgtrim_load_datareg: out    vl_logic;
        cfgtrim_drvmcbus: out    vl_logic;
        rdcfgcrc_drvmcbus: out    vl_logic;
        prgmmode_ld_reg : out    vl_logic;
        mfg_load_addrlat: out    vl_logic;
        mfg_load_datareg: out    vl_logic;
        readmfg_drvmcbus: out    vl_logic;
        flut_reset_flutaddrregctr: out    vl_logic;
        flut_load_flutaddrregupctr: out    vl_logic;
        flut_incr_flutaddrregupctr: out    vl_logic;
        flut_drvmcbus   : out    vl_logic;
        i2csa_drvmcbus  : out    vl_logic;
        readid_drvmcbus : out    vl_logic;
        readstat_drvmcbus: out    vl_logic;
        any_erase_iflg  : out    vl_logic;
        any_program_iflg: out    vl_logic;
        done_sel_array  : out    vl_logic;
        i2csa_sel_array : out    vl_logic;
        cfg_sel_array   : out    vl_logic;
        flut_sel_array  : out    vl_logic;
        trim_sel_array  : out    vl_logic;
        enable_verify   : out    vl_logic;
        trim_load_shdwregaddrlat: out    vl_logic;
        trimshdw_ld_latch: out    vl_logic;
        trimshdw_drvmcbus: out    vl_logic;
        measctrl_load_addrlat: out    vl_logic;
        measctrl_load_datalat: out    vl_logic;
        measresult_drvmcbus: out    vl_logic;
        cfgarray_data_enable: out    vl_logic;
        cfgtrim_sel_datareg: out    vl_logic;
        load_rdfaultenlat: out    vl_logic;
        fault_rdenstat_drvmcbus: out    vl_logic;
        fault_i2csa_erasprgm_iflg: out    vl_logic;
        north_keeper_drvmcbus: out    vl_logic;
        ldrecfg_pulse   : in     vl_logic;
        userlogicrst_pulse: in     vl_logic;
        usermode_iflg   : in     vl_logic;
        beuser_iflg     : in     vl_logic;
        erasedone_iflg  : in     vl_logic;
        progdone_iflg   : in     vl_logic;
        bei2csa_iflg    : in     vl_logic;
        progi2csa_iflg  : in     vl_logic;
        becfg_iflg      : in     vl_logic;
        progcfg_iflg    : in     vl_logic;
        eraseflut_iflg  : in     vl_logic;
        progusertag_iflg: in     vl_logic;
        eraseall_iflg   : in     vl_logic;
        progtrim_iflg   : in     vl_logic;
        rdshdw_iflg     : in     vl_logic;
        rdallshdw_iflg  : in     vl_logic;
        vercfg_iflg     : in     vl_logic;
        readstat_iflg   : in     vl_logic;
        i2csa_load_datareg: out    vl_logic;
        rdi2csa_iflg    : in     vl_logic;
        veri2csa_iflg   : in     vl_logic;
        readid_iflg     : in     vl_logic;
        readcfg_iflg    : in     vl_logic;
        rdcfgcrc_iflg   : in     vl_logic;
        rdusertag_iflg  : in     vl_logic;
        verflut_iflg    : in     vl_logic;
        rdallfault_iflg : in     vl_logic;
        readmfg_iflg    : in     vl_logic;
        vertrim_iflg    : in     vl_logic;
        writecfg_iflg   : in     vl_logic;
        wrrecfg_iflg    : in     vl_logic;
        wrrecfgmask_iflg: in     vl_logic;
        wrallrecfg_iflg : in     vl_logic;
        wrrdvid1_iflg   : in     vl_logic;
        wrrdvid2_iflg   : in     vl_logic;
        wrrdvid3_iflg   : in     vl_logic;
        wrrdvid4_iflg   : in     vl_logic;
        wrrdvid5_iflg   : in     vl_logic;
        wrrdvid6_iflg   : in     vl_logic;
        wrrdvid7_iflg   : in     vl_logic;
        wrrdvid8_iflg   : in     vl_logic;
        writeusertag_iflg: in     vl_logic;
        writemfg_iflg   : in     vl_logic;
        enprog_iflg     : in     vl_logic;
        wri2csa_iflg    : in     vl_logic;
        wrmeasctrl_iflg : in     vl_logic;
        rdmeasresult_iflg: in     vl_logic;
        writetrim_iflg  : in     vl_logic;
        readtrim_iflg   : in     vl_logic;
        wrtrimshdw_iflg : in     vl_logic;
        rdtrimshdw_iflg : in     vl_logic;
        ld_wr_row_addr  : in     vl_logic;
        ld_wr_start_addr: in     vl_logic;
        reset_wr_addr_ctr: in     vl_logic;
        drv_wr_addr_mcbus: in     vl_logic;
        ld_wr_addr_latch: in     vl_logic;
        incr_wr_addr_ctr: in     vl_logic;
        ld_wr_data_reg  : in     vl_logic;
        ld_rd_start_addr: in     vl_logic;
        reset_rd_addr_ctr: in     vl_logic;
        drv_rd_addr_mcbus: in     vl_logic;
        ld_rd_addr_latch: in     vl_logic;
        incr_rd_addr_ctr: in     vl_logic;
        ld_rmw_start_addr: in     vl_logic;
        drv_rmw_addr_mcbus: in     vl_logic;
        ld_rmw_addr_latch: in     vl_logic;
        drv_rmw_shdwreg_mcbus: in     vl_logic;
        ld_rmw_mshdw    : in     vl_logic;
        incr_rmw_addr_ctr: in     vl_logic;
        ld_vid_allshdw_addr_latch: in     vl_logic;
        reset_rfrsh_addr_ctr: in     vl_logic;
        drv_rfrsh_addr_mcbus: in     vl_logic;
        ld_rfrsh_addr_latch: in     vl_logic;
        drive_rfrsh_data_mcbus: in     vl_logic;
        ld_rfrsh_mshdw  : in     vl_logic;
        incr_rfrsh_addr_ctr: in     vl_logic;
        ld_rfrsh_sshdw  : in     vl_logic;
        ldvid_shdwreg   : in     vl_logic;
        wrir_en_i2c_dat : in     vl_logic;
        wrd_en_i2c_dat  : in     vl_logic;
        prgmarray       : in     vl_logic;
        rdd_in          : in     vl_logic;
        mfg_mode        : in     vl_logic;
        nocfgwrprotec_b : in     vl_logic;
        pinnocfgwrprotec_b: in     vl_logic;
        gpio_reg        : in     vl_logic;
        ld_crc_s_latch  : in     vl_logic;
        donebit         : in     vl_logic;
        prgm_mode       : in     vl_logic;
        twi_fl_prgm_eep : in     vl_logic;
        rdsoftfault_iflg: in     vl_logic;
        examine_fldonebit: in     vl_logic;
        m_progcfg_iflg  : in     vl_logic;
        m_progusertag_iflg: in     vl_logic;
        m_progtrim_iflg : in     vl_logic;
        trim_rfrsh      : in     vl_logic;
        rdfaulten_iflg  : in     vl_logic;
        addr_out        : in     vl_logic_vector(7 downto 0);
        tst_north_keeper_iflg: in     vl_logic
    );
end control;
