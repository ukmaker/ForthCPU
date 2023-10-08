library verilog;
use verilog.vl_types.all;
entity ser_aux_iref is
    port(
        i50uconst       : inout  vl_logic_vector(1 downto 0);
        i50urpoly       : inout  vl_logic_vector(1 downto 0);
        i50ucte         : inout  vl_logic_vector(11 downto 0);
        i50uply         : inout  vl_logic_vector(9 downto 0);
        vccp            : inout  vl_logic;
        vssp            : inout  vl_logic;
        vssps           : inout  vl_logic;
        setirpoly       : in     vl_logic_vector(1 downto 0);
        seticonst       : in     vl_logic_vector(1 downto 0);
        pwdnb           : in     vl_logic
    );
end ser_aux_iref;
