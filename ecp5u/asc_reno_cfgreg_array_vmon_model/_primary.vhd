library verilog;
use verilog.vl_types.all;
entity asc_reno_cfgreg_array_vmon_model is
    port(
        cfg_vm          : inout  vl_logic_vector(7 downto 0);
        ldshdwreg       : in     vl_logic;
        ldmshdw         : in     vl_logic;
        ldsshdw         : in     vl_logic;
        rdshdw          : in     vl_logic;
        reset_n         : in     vl_logic
    );
end asc_reno_cfgreg_array_vmon_model;
