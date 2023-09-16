library verilog;
use verilog.vl_types.all;
entity cfg_fifo is
    generic(
        FIFO_DATW       : integer := 8;
        FIFO_MAXW       : integer := 16;
        FIFO_DEPTH      : integer := 8;
        FIFO_CNTW       : integer := 3
    );
    port(
        dout            : out    vl_logic_vector;
        empty           : out    vl_logic;
        full            : out    vl_logic;
        overflow        : out    vl_logic;
        rst_async       : in     vl_logic;
        wclk            : in     vl_logic;
        rclk            : in     vl_logic;
        we              : in     vl_logic;
        w_16            : in     vl_logic;
        re              : in     vl_logic;
        r_16            : in     vl_logic;
        din             : in     vl_logic_vector
    );
end cfg_fifo;
