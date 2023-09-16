library verilog;
use verilog.vl_types.all;
entity write_prgm_dat is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2;
        st4             : integer := 6
    );
    port(
        ld_wr_row_addr  : out    vl_logic;
        ld_prgmarray_slaveflgreg: out    vl_logic;
        wr_d            : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        prgmarray       : in     vl_logic
    );
end write_prgm_dat;
