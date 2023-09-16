library verilog;
use verilog.vl_types.all;
entity asc_vmon_tristate_keeper is
    port(
        \bus\           : inout  vl_logic_vector(7 downto 0)
    );
end asc_vmon_tristate_keeper;
