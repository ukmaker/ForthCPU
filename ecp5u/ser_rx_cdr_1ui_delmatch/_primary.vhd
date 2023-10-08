library verilog;
use verilog.vl_types.all;
entity ser_rx_cdr_1ui_delmatch is
    port(
        ck              : in     vl_logic;
        ckn             : in     vl_logic;
        d               : in     vl_logic;
        vccd            : inout  vl_logic;
        vssd            : inout  vl_logic;
        ckoutn          : out    vl_logic;
        ckoutp          : out    vl_logic;
        dout            : out    vl_logic;
        vssds           : inout  vl_logic
    );
end ser_rx_cdr_1ui_delmatch;
