library verilog;
use verilog.vl_types.all;
entity twi_rdat_latch_array is
    port(
        twi_resetb      : in     vl_logic;
        twi_rdat_read   : in     vl_logic;
        twi_rdat_addr   : in     vl_logic_vector(3 downto 0);
        twi_rdat_data_from_latch: out    vl_logic_vector(7 downto 0);
        twi_rdat_read_reg: in     vl_logic;
        twi_rdat_reg_to_latch_array_0: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_1: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_2: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_3: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_4: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_5: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_6: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_7: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_8: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_9: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_10: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_11: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_12: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_13: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_14: in     vl_logic_vector(7 downto 0);
        twi_rdat_reg_to_latch_array_15: in     vl_logic_vector(7 downto 0)
    );
end twi_rdat_latch_array;
