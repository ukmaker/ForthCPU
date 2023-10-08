library verilog;
use verilog.vl_types.all;
entity ser_ch_iref is
    port(
        i50u_aux_const  : inout  vl_logic_vector(1 downto 0);
        i50u_aux_rpoly  : inout  vl_logic_vector(1 downto 0);
        i50u_ch_cte     : inout  vl_logic_vector(11 downto 0);
        i50u_ch_ply     : inout  vl_logic_vector(9 downto 0);
        vccq            : inout  vl_logic;
        vssq            : inout  vl_logic;
        vssqs           : inout  vl_logic;
        pwdnb           : in     vl_logic;
        seti_ch_const   : in     vl_logic_vector(1 downto 0);
        seti_ch_rpoly   : in     vl_logic_vector(1 downto 0)
    );
end ser_ch_iref;
