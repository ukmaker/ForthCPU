lappend auto_path "C:/lscc/diamond/3.12/data/script"
package require simulation_generation
set ::bali::simulation::Para(DEVICEFAMILYNAME) {MachXO3L}
set ::bali::simulation::Para(PROJECT) {processorCoreInstructionTestbench}
set ::bali::simulation::Para(PROJECTPATH) {C:/Users/Duncan/git/ForthCPU/processorCore/test}
set ::bali::simulation::Para(FILELIST) {"C:/Users/Duncan/git/ForthCPU/registerSequencer/source/registerSequencer.v" "C:/Users/Duncan/git/ForthCPU/opxMultiplexer/source/opxMultiplexer.v" "C:/Users/Duncan/git/ForthCPU/generalGroupDecoder/source/generalGroupDecoder.v" "C:/Users/Duncan/git/ForthCPU/jumpGroupDecoder/source/jumpGroupDecoder.v" "C:/Users/Duncan/git/ForthCPU/loadStoreGroupDecoder/source/loadStoreGroupDecoder.v" "C:/Users/Duncan/git/ForthCPU/aluGroupDecoder/source/aluGroupDecoder.v" "C:/Users/Duncan/git/ForthCPU/interruptLogic/source/interruptStateMachine.v" "C:/Users/Duncan/git/ForthCPU/programCounter/source/programCounter.v" "C:/Users/Duncan/git/ForthCPU/busController/source/busSequencer.v" "C:/Users/Duncan/git/ForthCPU/busController/source/busController.v" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registerFile.v" "C:/Users/Duncan/git/ForthCPU/aluB/source/ccRegisters.v" "C:/Users/Duncan/git/ForthCPU/aluB/source/aluBMux.v" "C:/Users/Duncan/git/ForthCPU/aluB/source/aluAMux.v" "C:/Users/Duncan/git/ForthCPU/aluB/source/alu.v" "C:/Users/Duncan/git/ForthCPU/aluB/source/fullALU.v" "C:/Users/Duncan/git/ForthCPU/instructionPhaseDecoder/source/instructionPhaseDecoder.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/debugDecoder.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/register.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/upCounter.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/requestGenerator.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/oneOfEightDecoder.v" "C:/Users/Duncan/git/ForthCPU/debugPort/source/debugPort.v" "C:/Users/Duncan/git/ForthCPU/processorCore/source/core.v" "C:/Users/Duncan/git/ForthCPU/processorCoreInstructionTests.sv" "C:/Users/Duncan/git/ForthCPU/debugPort/source/stopSynchroniser.v" "C:/Users/Duncan/git/ForthCPU/constants.v" "C:/Users/Duncan/git/ForthCPU/instructionTestSetup.sv" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" }
set ::bali::simulation::Para(LANGSTDLIST) {"Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "System Verilog" "Verilog 2001" "Verilog 2001" "System Verilog" "" "" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_machxo3l}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {processorCoreInstructionTests}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(INSTALLATIONPATH) {C:/lscc/diamond/3.12}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ModelSim_Run
