library verilog;
use verilog.vl_types.all;
entity ts_cic_integrator is
    generic(
        SIZE            : integer := 16;
        WIDTH           : integer := 25
    );
    port(
        asc_clk         : in     vl_logic;
        ts_resetb       : in     vl_logic;
        ts_clr          : in     vl_logic;
        ts_datain       : in     vl_logic_vector;
        ts_dataout      : out    vl_logic_vector
    );
end ts_cic_integrator;
