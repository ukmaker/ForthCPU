library verilog;
use verilog.vl_types.all;
entity wrir_sync is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2;
        st4             : integer := 6;
        st5             : integer := 7;
        st6             : integer := 5;
        st7             : integer := 4
    );
    port(
        en_i2c_dat      : out    vl_logic;
        ldir            : out    vl_logic;
        ldiflgreg       : out    vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        wrir_in         : in     vl_logic;
        refresh_on      : in     vl_logic
    );
end wrir_sync;
