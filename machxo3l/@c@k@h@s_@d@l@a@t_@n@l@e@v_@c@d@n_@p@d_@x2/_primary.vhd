library verilog;
use verilog.vl_types.all;
entity CKHS_DLAT_NLEV_CDN_PD_X2 is
    port(
        q               : out    vl_logic;
        qn              : out    vl_logic;
        d               : in     vl_logic;
        ck              : in     vl_logic;
        cdn             : in     vl_logic;
        pd              : in     vl_logic
    );
end CKHS_DLAT_NLEV_CDN_PD_X2;
