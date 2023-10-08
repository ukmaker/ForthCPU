library verilog;
use verilog.vl_types.all;
entity scan_mux is
    port(
        scan_in_7       : in     vl_logic;
        scan_in_6       : in     vl_logic;
        cib_dis         : in     vl_logic;
        mc1_chif_ctl_ch0: in     vl_logic_vector(263 downto 0);
        mc1_chif_ctl_ch1: in     vl_logic_vector(263 downto 0);
        mc1_dif_ctl     : in     vl_logic_vector(159 downto 0);
        mc1_ser_ctl_ch0 : in     vl_logic_vector(87 downto 0);
        mc1_ser_ctl_ch1 : in     vl_logic_vector(87 downto 0);
        mc1_ser_ctl_dl  : in     vl_logic_vector(71 downto 0);
        ser_sts_1_dl_25 : in     vl_logic_vector(7 downto 0);
        ser_sts_2_ch_27_0: in     vl_logic_vector(7 downto 0);
        ser_sts_2_ch_27_1: in     vl_logic_vector(7 downto 0);
        ser_sts_3_ch_28_0: in     vl_logic_vector(7 downto 0);
        ser_sts_3_ch_28_1: in     vl_logic_vector(7 downto 0);
        ser_sts_4_ch_29_0: in     vl_logic_vector(7 downto 0);
        ser_sts_4_ch_29_1: in     vl_logic_vector(7 downto 0);
        mc1_chif_ctl_ch0_scmx: out    vl_logic_vector(263 downto 0);
        mc1_chif_ctl_ch1_scmx: out    vl_logic_vector(263 downto 0);
        mc1_dif_ctl_scmx: out    vl_logic_vector(159 downto 0);
        mc1_ser_ctl_ch0_scmx: out    vl_logic_vector(87 downto 0);
        mc1_ser_ctl_ch1_scmx: out    vl_logic_vector(87 downto 0);
        mc1_ser_ctl_dl_scmx: out    vl_logic_vector(71 downto 0);
        ser_sts_1_dl_25_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_2_ch_27_0_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_2_ch_27_1_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_3_ch_28_0_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_3_ch_28_1_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_4_ch_29_0_scmx: out    vl_logic_vector(7 downto 0);
        ser_sts_4_ch_29_1_scmx: out    vl_logic_vector(7 downto 0)
    );
end scan_mux;
