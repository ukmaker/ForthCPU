library verilog;
use verilog.vl_types.all;
entity twi_latch_array is
    port(
        twi_resetb      : in     vl_logic;
        twi_wdat_write  : in     vl_logic;
        twi_wdat_addr   : in     vl_logic_vector(3 downto 0);
        twi_wdat_data_from_3wire: in     vl_logic_vector(7 downto 0);
        twi_wrclk       : in     vl_logic;
        twi_latch_array_0: out    vl_logic_vector(7 downto 0);
        twi_latch_array_1: out    vl_logic_vector(7 downto 0);
        twi_latch_array_2: out    vl_logic_vector(7 downto 0);
        twi_latch_array_3: out    vl_logic_vector(7 downto 0);
        twi_latch_array_4: out    vl_logic_vector(7 downto 0);
        twi_latch_array_5: out    vl_logic_vector(7 downto 0);
        twi_latch_array_6: out    vl_logic_vector(7 downto 0);
        twi_latch_array_7: out    vl_logic_vector(7 downto 0);
        twi_latch_array_8: out    vl_logic_vector(7 downto 0);
        twi_latch_array_9: out    vl_logic_vector(7 downto 0);
        twi_latch_array_10: out    vl_logic_vector(7 downto 0);
        twi_latch_array_11: out    vl_logic_vector(7 downto 0);
        twi_latch_array_12: out    vl_logic_vector(7 downto 0);
        twi_latch_array_13: out    vl_logic_vector(7 downto 0);
        twi_latch_array_14: out    vl_logic_vector(7 downto 0);
        twi_latch_array_15: out    vl_logic_vector(7 downto 0)
    );
end twi_latch_array;
