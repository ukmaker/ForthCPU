library verilog;
use verilog.vl_types.all;
entity ser_aux_txlol is
    port(
        refclk          : in     vl_logic;
        divclk          : in     vl_logic;
        pwr_on_rst      : in     vl_logic;
        reset           : in     vl_logic;
        lock_diff       : in     vl_logic_vector(1 downto 0);
        refck_mode      : in     vl_logic_vector(1 downto 0);
        pll_lol         : out    vl_logic
    );
end ser_aux_txlol;
