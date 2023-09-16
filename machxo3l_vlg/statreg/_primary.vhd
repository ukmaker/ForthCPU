library verilog;
use verilog.vl_types.all;
entity statreg is
    port(
        statreg_out     : out    vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        readstat_drvmcbus: in     vl_logic;
        addrbit0        : in     vl_logic;
        donebit         : in     vl_logic;
        i2csadone       : in     vl_logic;
        prgm_mode       : in     vl_logic;
        mfg_mode        : in     vl_logic;
        refresh_on      : in     vl_logic;
        any_erase_iflg  : in     vl_logic;
        any_program_iflg: in     vl_logic;
        eraseflut_iflg  : in     vl_logic;
        faultlog_in_progress: in     vl_logic;
        crcerror        : in     vl_logic;
        faultlog_full   : in     vl_logic;
        faultlog_next_row: in     vl_logic_vector(3 downto 0)
    );
end statreg;
