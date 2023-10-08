library verilog;
use verilog.vl_types.all;
entity bidir_od_pad is
    generic(
        TIN_DLY         : integer := 1;
        TOUT_DLY        : integer := 3
    );
    port(
        dout_2_pad      : in     vl_logic;
        oe_n            : in     vl_logic;
        pad             : inout  vl_logic;
        din_2_core      : out    vl_logic
    );
end bidir_od_pad;
