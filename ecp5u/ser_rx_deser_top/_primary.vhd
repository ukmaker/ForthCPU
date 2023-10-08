library verilog;
use verilog.vl_types.all;
entity ser_rx_deser_top is
    generic(
        LOSSOFLOCK      : integer := 0
    );
    port(
        rck             : out    vl_logic;
        rd              : out    vl_logic_vector(9 downto 0);
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        vssrxs          : inout  vl_logic;
        clk2            : in     vl_logic;
        din             : in     vl_logic;
        sel4            : in     vl_logic
    );
end ser_rx_deser_top;
