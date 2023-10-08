library verilog;
use verilog.vl_types.all;
entity pp_cc is
    generic(
        PTR_MSB         : integer := 4
    );
    port(
        wclk            : in     vl_logic;
        wrst_n          : in     vl_logic;
        rclk            : in     vl_logic;
        rrst_n          : in     vl_logic;
        d_in            : in     vl_logic_vector(10 downto 0);
        rx_even_in      : in     vl_logic;
        d_out           : out    vl_logic_vector(10 downto 0);
        rx_even_out     : out    vl_logic;
        re_out          : out    vl_logic;
        we_out          : out    vl_logic;
        match1_d        : in     vl_logic_vector(9 downto 0);
        match2_d        : in     vl_logic_vector(9 downto 0);
        match3_d        : in     vl_logic_vector(9 downto 0);
        match4_d        : in     vl_logic_vector(9 downto 0);
        match2_en       : in     vl_logic;
        match4_en       : in     vl_logic;
        min_ipg_cnt     : in     vl_logic_vector(1 downto 0);
        high_mark       : in     vl_logic_vector(3 downto 0);
        low_mark        : in     vl_logic_vector(3 downto 0);
        overrun         : out    vl_logic;
        underrun        : out    vl_logic
    );
end pp_cc;
