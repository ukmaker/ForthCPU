library verilog;
use verilog.vl_types.all;
entity ser_rx_cdr_1uislip is
    port(
        ckdiv2_outn     : out    vl_logic;
        ckdiv2_outp     : out    vl_logic;
        d_out           : out    vl_logic;
        vccrx           : inout  vl_logic;
        vssrx           : inout  vl_logic;
        vssrxs          : inout  vl_logic;
        ckn             : in     vl_logic;
        ckp             : in     vl_logic;
        d               : in     vl_logic;
        enable          : in     vl_logic
    );
end ser_rx_cdr_1uislip;
