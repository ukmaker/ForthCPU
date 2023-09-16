library verilog;
use verilog.vl_types.all;
entity asc_tristate_if is
    port(
        bus_in          : out    vl_logic_vector(7 downto 0);
        bus_out         : in     vl_logic_vector(7 downto 0);
        bus_oe          : in     vl_logic;
        vddd            : inout  vl_logic;
        vssd            : inout  vl_logic;
        \bus\           : inout  vl_logic_vector(7 downto 0)
    );
end asc_tristate_if;
