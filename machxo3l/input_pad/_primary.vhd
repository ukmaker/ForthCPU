library verilog;
use verilog.vl_types.all;
entity input_pad is
    generic(
        TIN_DLY         : integer := 1
    );
    port(
        pad             : in     vl_logic;
        din_2_core      : out    vl_logic
    );
end input_pad;
