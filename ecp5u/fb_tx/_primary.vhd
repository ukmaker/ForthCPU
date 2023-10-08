library verilog;
use verilog.vl_types.all;
entity fb_tx is
    port(
        wclk            : in     vl_logic;
        rclk            : in     vl_logic;
        rstb_txp        : in     vl_logic;
        rstb_txf        : in     vl_logic;
        data_i          : in     vl_logic_vector(23 downto 0);
        tx_gear_mode    : in     vl_logic;
        data_o          : out    vl_logic_vector(11 downto 0);
        error           : out    vl_logic
    );
end fb_tx;
