library verilog;
use verilog.vl_types.all;
entity ts_alupath is
    generic(
        WIDTH           : integer := 32
    );
    port(
        asc_clk         : in     vl_logic;
        reset_n         : in     vl_logic;
        mul_done        : in     vl_logic;
        acc_datain      : in     vl_logic_vector;
        ld_acc_reg      : in     vl_logic;
        clr_acc_reg     : in     vl_logic;
        rshift_acc_reg  : in     vl_logic;
        ld_f_reg        : in     vl_logic;
        clr_f_reg       : in     vl_logic;
        q_datain        : in     vl_logic_vector(15 downto 0);
        ld_q_reg        : in     vl_logic;
        rshift_q_reg    : in     vl_logic;
        m_datain        : in     vl_logic_vector;
        ld_m_reg        : in     vl_logic;
        alu_mode        : in     vl_logic_vector(2 downto 0);
        q_allzero       : out    vl_logic;
        m_allzero       : out    vl_logic;
        x               : out    vl_logic;
        x_1             : out    vl_logic;
        x_2             : out    vl_logic;
        f               : out    vl_logic;
        q_dataout       : out    vl_logic_vector(16 downto 0);
        m_dataout       : out    vl_logic_vector;
        acc_dataout     : out    vl_logic_vector;
        ts_ld_from_i2c_alu_m_lo_reg: in     vl_logic;
        ts_ld_from_i2c_alu_m_ml_reg: in     vl_logic;
        ts_ld_from_i2c_alu_m_mh_reg: in     vl_logic;
        ts_ld_from_i2c_alu_m_hi_reg: in     vl_logic;
        ts_ld_from_i2c_alu_acc_lo_reg: in     vl_logic;
        ts_ld_from_i2c_alu_acc_ml_reg: in     vl_logic;
        ts_ld_from_i2c_alu_acc_mh_reg: in     vl_logic;
        ts_ld_from_i2c_alu_acc_hi_reg: in     vl_logic;
        ts_ld_from_i2c_alu_q_lo_reg: in     vl_logic;
        ts_ld_from_i2c_alu_q_md_reg: in     vl_logic;
        ts_ld_from_i2c_alu_q_hi_reg: in     vl_logic;
        ts_ld_from_i2c_alu_cmd: in     vl_logic;
        ts_vol_rd       : in     vl_logic;
        ts_vol_ld_data  : in     vl_logic;
        ts_datain       : in     vl_logic_vector(7 downto 0);
        ts_alu_dataout  : out    vl_logic_vector(7 downto 0)
    );
end ts_alupath;
