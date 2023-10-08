library verilog;
use verilog.vl_types.all;
entity read_mod_write_dat is
    generic(
        init            : integer := 0;
        st1             : integer := 1;
        st2             : integer := 3;
        st3             : integer := 2;
        st4             : integer := 6;
        st5             : integer := 7;
        st6             : integer := 5;
        st7             : integer := 4;
        st8             : integer := 12;
        st9             : integer := 13;
        st10            : integer := 15;
        st11            : integer := 14;
        st12            : integer := 10;
        st13            : integer := 11;
        st14            : integer := 9;
        st15            : integer := 8;
        st16            : integer := 24;
        st17            : integer := 16;
        st18            : integer := 17;
        st19            : integer := 19
    );
    port(
        ld_rmw_start_addr: out    vl_logic;
        drv_rmw_addr_mcbus: out    vl_logic;
        ld_rmw_addr_latch: out    vl_logic;
        drv_rmw_shdwreg_mcbus: out    vl_logic;
        ld_rmw_mshdw    : out    vl_logic;
        incr_rmw_addr_ctr: out    vl_logic;
        drv_rmw_mux_mcbus: out    vl_logic;
        rmw_mux         : out    vl_logic_vector(7 downto 0);
        mc_bus          : in     vl_logic_vector(7 downto 0);
        runen_rmw       : in     vl_logic;
        wr_ir           : in     vl_logic;
        wr_d            : in     vl_logic;
        rd_d            : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end read_mod_write_dat;
