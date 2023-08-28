lappend auto_path "C:/lscc/diamond/3.12/data/script"
package require simulation_generation
set ::bali::simulation::Para(DEVICEFAMILYNAME) {MachXO3L}
set ::bali::simulation::Para(PROJECT) {regitser_file}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/Duncan/git/ForthCPU}
set ::bali::simulation::Para(FILELIST) {"C:/Users/Duncan/git/ForthCPU/register.v" "C:/Users/Duncan/git/ForthCPU/register_file.v" "C:/Users/Duncan/git/ForthCPU/register_file_testbench.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/data_sources.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/registers.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/regs_testbench.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/multiplier.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/alu.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/testbench.v" "C:/Users/Duncan/git/ForthCPU/register_testbench.v" "C:/Users/Duncan/git/ForthCPU/impl1/source/data_sources_testbench.v" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" }
set ::bali::simulation::Para(LANGSTDLIST) {"System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" "System Verilog" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo3l}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {register_file_testbench}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VERILOG}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(INSTALLATIONPATH) {C:/lscc/diamond/3.12}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ModelSim_Run
