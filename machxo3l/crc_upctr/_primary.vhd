library verilog;
use verilog.vl_types.all;
entity crc_upctr is
    port(
        ctrbit          : out    vl_logic_vector(2 downto 0);
        reset           : in     vl_logic;
        toggle          : in     vl_logic;
        clk             : in     vl_logic
    );
end crc_upctr;
