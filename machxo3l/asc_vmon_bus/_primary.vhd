library verilog;
use verilog.vl_types.all;
entity asc_vmon_bus is
    port(
        \bus\           : inout  vl_logic_vector(7 downto 0);
        bus_in          : out    vl_logic_vector(7 downto 0);
        bus_out         : in     vl_logic_vector(7 downto 0);
        bus_oe          : in     vl_logic;
        vddd            : inout  vl_logic;
        vssd            : inout  vl_logic
    );
end asc_vmon_bus;
