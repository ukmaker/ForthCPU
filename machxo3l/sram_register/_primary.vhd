library verilog;
use verilog.vl_types.all;
entity sram_register is
    port(
        sram_sec_prog   : out    vl_logic;
        sram_sec_read   : out    vl_logic;
        sram_done       : out    vl_logic;
        sram_ues        : out    vl_logic_vector(31 downto 0);
        sf_exec_buf     : out    vl_logic_vector(127 downto 0);
        sram_crc        : out    vl_logic_vector(31 downto 0);
        UCODE_DEFAULT   : in     vl_logic_vector(31 downto 0);
        CRC32_DEFAULT   : in     vl_logic_vector(31 downto 0);
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        scanen          : in     vl_logic;
        mfg_crc_sel     : in     vl_logic;
        isc_exec_b      : in     vl_logic;
        isc_exec_e      : in     vl_logic;
        buf128_dat      : in     vl_logic_vector(127 downto 0);
        sf_prog_sec_eqv : in     vl_logic;
        sf_prog_ucode_qual: in     vl_logic;
        sf_prog_done_qual: in     vl_logic;
        sf_erase_done_qual: in     vl_logic;
        sf_prog_sec_qual: in     vl_logic;
        sf_prog_sed_crc_qual: in     vl_logic;
        sf_read_sed_crc_qual: in     vl_logic;
        sed_prog_sed_crc_qual: in     vl_logic;
        sf_be_success   : in     vl_logic;
        pe_rdata        : in     vl_logic_vector(71 downto 0);
        sed_crc_reg     : in     vl_logic_vector(31 downto 0);
        sdm_start_bse   : in     vl_logic;
        flash_sec_read  : in     vl_logic;
        flash_done      : in     vl_logic
    );
end sram_register;
