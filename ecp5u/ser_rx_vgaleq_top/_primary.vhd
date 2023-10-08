library verilog;
use verilog.vl_types.all;
entity ser_rx_vgaleq_top is
    port(
        rxdon           : out    vl_logic;
        rxdop           : out    vl_logic;
        slb_dn          : out    vl_logic;
        slb_dp          : out    vl_logic;
        vccib           : inout  vl_logic;
        vccrx           : inout  vl_logic;
        vccrx25         : inout  vl_logic;
        vssrx           : inout  vl_logic;
        vssrxs          : inout  vl_logic;
        hdinn           : in     vl_logic;
        hdinp           : in     vl_logic;
        pwdnb           : in     vl_logic;
        rate_sel        : in     vl_logic_vector(3 downto 0);
        rcv_dcc_en      : in     vl_logic;
        req_en          : in     vl_logic;
        req_i_set       : in     vl_logic_vector(2 downto 0);
        req_lvl_set     : in     vl_logic_vector(1 downto 0);
        rterm_rx        : in     vl_logic_vector(3 downto 0);
        slb_eq2t_en     : in     vl_logic;
        ofen            : out    vl_logic;
        on_los          : out    vl_logic;
        ofep            : out    vl_logic;
        op_los          : out    vl_logic;
        i50u4leqpoly    : inout  vl_logic_vector(1 downto 0);
        rxterm_cm       : in     vl_logic_vector(1 downto 0);
        rxin_cm         : in     vl_logic_vector(1 downto 0);
        leq_offset_sel  : in     vl_logic;
        leq_offset_trim : in     vl_logic_vector(2 downto 0);
        i50u4leqconst   : in     vl_logic_vector(1 downto 0)
    );
end ser_rx_vgaleq_top;
