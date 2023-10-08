library verilog;
use verilog.vl_types.all;
entity ser_rx_los is
    port(
        los             : out    vl_logic;
        sq_en           : in     vl_logic;
        sqth            : in     vl_logic_vector(2 downto 0);
        refn_los        : in     vl_logic;
        vccrx           : in     vl_logic;
        vin             : in     vl_logic;
        vip             : in     vl_logic;
        vssrx           : in     vl_logic;
        ceq             : in     vl_logic_vector(1 downto 0);
        hyst            : in     vl_logic;
        refp_los        : in     vl_logic;
        pwrup           : in     vl_logic;
        vssrxs          : inout  vl_logic
    );
end ser_rx_los;
