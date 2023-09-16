library verilog;
use verilog.vl_types.all;
entity sram_qual is
    port(
        sf_prog_exec    : out    vl_logic;
        sf_read_exec    : out    vl_logic;
        sf_erase_exec   : out    vl_logic;
        sf_prog_incr_exec: out    vl_logic;
        sf_read_incr_exec: out    vl_logic;
        sf_pcs_write_exec: out    vl_logic;
        sf_ebr_write_exec: out    vl_logic;
        sf_pcs_read_exec: out    vl_logic;
        sf_ebr_read_exec: out    vl_logic;
        sf_write_bus_addr_exec: out    vl_logic;
        sf_init_addr_exec: out    vl_logic;
        sf_write_addr_exec: out    vl_logic;
        sf_address_shift_exec: out    vl_logic;
        sf_program_qual : in     vl_logic;
        sf_read_qual    : in     vl_logic;
        sf_erase_qual   : in     vl_logic;
        sf_address_shift_qual: in     vl_logic;
        sf_init_addr_qual: in     vl_logic;
        sf_write_addr_qual: in     vl_logic;
        sf_prog_incr_rti_qual: in     vl_logic;
        sf_prog_incr_enc_qual: in     vl_logic;
        sf_prog_incr_cmp_qual: in     vl_logic;
        sf_prog_incr_cne_qual: in     vl_logic;
        sf_vfy_incr_rti_qual: in     vl_logic;
        sf_write_bus_addr_qual: in     vl_logic;
        sf_pcs_write_qual: in     vl_logic;
        sf_pcs_read_qual: in     vl_logic;
        sf_ebr_write_qual: in     vl_logic;
        sf_ebr_read_qual: in     vl_logic;
        sed_init_addr_qual: in     vl_logic;
        sed_write_addr_qual: in     vl_logic;
        sed_read_incr_qual: in     vl_logic
    );
end sram_qual;
