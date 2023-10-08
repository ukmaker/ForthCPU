library verilog;
use verilog.vl_types.all;
entity ser_aux_pll is
    generic(
        SER_IGNOREBIASCURRENT: integer := 0
    );
    port(
        ck_fbout        : out    vl_logic;
        hsclk2ndn       : out    vl_logic;
        hsclk2ndp       : out    vl_logic;
        hsclkn          : out    vl_logic;
        hsclkp          : out    vl_logic;
        syncout         : out    vl_logic;
        syncout2ndp     : out    vl_logic;
        syncout2ndn     : out    vl_logic;
        tck_full        : out    vl_logic;
        i50uconst       : inout  vl_logic_vector(1 downto 0);
        powp_filt       : inout  vl_logic;
        vcca            : inout  vl_logic;
        vssa            : inout  vl_logic;
        vssas           : inout  vl_logic;
        bitclk_local_en : in     vl_logic;
        bitclk_nd_en    : in     vl_logic;
        ck_ref          : in     vl_logic;
        pdnb            : in     vl_logic;
        pllrst          : in     vl_logic;
        reg_en          : in     vl_logic;
        sel_div25       : in     vl_logic;
        sel_refckmode   : in     vl_logic_vector(1 downto 0);
        sel_vcodiv      : in     vl_logic_vector(2 downto 0);
        setbiasi        : in     vl_logic_vector(1 downto 0);
        seti4cpp        : in     vl_logic_vector(3 downto 0);
        seti4cpz        : in     vl_logic_vector(3 downto 0);
        seti4vco        : in     vl_logic_vector(1 downto 0);
        seticp4p        : in     vl_logic_vector(1 downto 0);
        seticp4z        : in     vl_logic_vector(2 downto 0);
        setinitvct      : in     vl_logic_vector(1 downto 0);
        setiscl4vco     : in     vl_logic_vector(2 downto 0);
        setp1gm         : in     vl_logic_vector(2 downto 0);
        setp2agm        : in     vl_logic_vector(2 downto 0);
        setpllrc        : in     vl_logic_vector(5 downto 0);
        setzgm          : in     vl_logic_vector(2 downto 0);
        sync_en         : in     vl_logic;
        syncin          : in     vl_logic
    );
end ser_aux_pll;
