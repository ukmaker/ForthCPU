library verilog;
use verilog.vl_types.all;
entity ts_alu is
    generic(
        WIDTH           : integer := 32
    );
    port(
        s               : in     vl_logic_vector(2 downto 0);
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        f               : out    vl_logic_vector
    );
end ts_alu;
