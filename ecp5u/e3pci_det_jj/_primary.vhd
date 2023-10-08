library verilog;
use verilog.vl_types.all;
entity e3pci_det_jj is
    port(
        clk             : in     vl_logic;
        rstb            : in     vl_logic;
        pcie_mode       : in     vl_logic;
        pci_det_ct      : in     vl_logic;
        pci_det_time_sel: in     vl_logic_vector(1 downto 0);
        pci_det_pulse   : out    vl_logic
    );
end e3pci_det_jj;
