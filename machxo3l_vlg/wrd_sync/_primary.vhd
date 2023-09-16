library verilog;
use verilog.vl_types.all;
entity wrd_sync is
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
        wrd_out         : out    vl_logic;
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        wrd_in          : in     vl_logic
    );
end wrd_sync;
