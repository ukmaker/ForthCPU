library verilog;
use verilog.vl_types.all;
entity ts_boothmul_fsm is
    generic(
        idle_d          : integer := 1;
        add_d           : integer := 2;
        sub_d           : integer := 4;
        rshift_d        : integer := 8;
        mulend_d        : integer := 16
    );
    port(
        asc_clk         : in     vl_logic;
        reset_n         : in     vl_logic;
        mul_start       : in     vl_logic;
        q_allzero       : in     vl_logic;
        m_allzero       : in     vl_logic;
        x               : in     vl_logic;
        x_1             : in     vl_logic;
        x_2             : in     vl_logic;
        f               : in     vl_logic;
        ld_acc_reg      : out    vl_logic;
        clr_acc_reg     : out    vl_logic;
        ld_f_reg        : out    vl_logic;
        clr_f_reg       : out    vl_logic;
        rshift_acc_reg  : out    vl_logic;
        rshift_q_reg    : out    vl_logic;
        alu_mode        : out    vl_logic_vector(2 downto 0);
        ct16            : in     vl_logic;
        clr_cnt         : out    vl_logic;
        incr_cnt        : out    vl_logic;
        mul_done        : out    vl_logic
    );
end ts_boothmul_fsm;
