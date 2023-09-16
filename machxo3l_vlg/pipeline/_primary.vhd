library verilog;
use verilog.vl_types.all;
entity pipeline is
    generic(
        stages          : integer := 1;
        width           : integer := 1;
        rstval          : integer := 0
    );
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        ena             : in     vl_logic;
        inp             : in     vl_logic_vector;
        outp            : out    vl_logic_vector
    );
end pipeline;
