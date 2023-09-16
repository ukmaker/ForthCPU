library verilog;
use verilog.vl_types.all;
entity sci_register_bit is
    generic(
        resetvalue      : integer := 0
    );
    port(
        \out\           : out    vl_logic;
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        \in\            : in     vl_logic;
        wrena           : in     vl_logic
    );
end sci_register_bit;
