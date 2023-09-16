library verilog;
use verilog.vl_types.all;
entity pin_sense is
    generic(
        N_PIN           : integer := 3
    );
    port(
        pin_val         : out    vl_logic_vector;
        por             : in     vl_logic;
        smclk           : in     vl_logic;
        pin_cap         : in     vl_logic;
        pin_in          : in     vl_logic_vector
    );
end pin_sense;
