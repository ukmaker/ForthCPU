library verilog;
use verilog.vl_types.all;
entity ser_rx_cdr_mux31ux4 is
    port(
        z               : out    vl_logic;
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        d2              : in     vl_logic;
        sd              : in     vl_logic_vector(2 downto 0);
        vccd            : inout  vl_logic;
        vssd            : inout  vl_logic;
        vssds           : inout  vl_logic
    );
end ser_rx_cdr_mux31ux4;
