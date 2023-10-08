library verilog;
use verilog.vl_types.all;
entity ser_lg_l2hlsh_tws is
    port(
        out_hv          : out    vl_logic;
        outb_hv         : out    vl_logic;
        vccl            : inout  vl_logic;
        vccl25          : inout  vl_logic;
        vssl            : inout  vl_logic;
        lin             : in     vl_logic
    );
end ser_lg_l2hlsh_tws;
