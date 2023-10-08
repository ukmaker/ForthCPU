library verilog;
use verilog.vl_types.all;
entity lockup_reg_negedge is
    generic(
        RESET_VALUE     : integer := 0
    );
    port(
        din             : in     vl_logic;
        dout            : out    vl_logic;
        clock           : in     vl_logic;
        reset_n         : in     vl_logic
    );
end lockup_reg_negedge;
