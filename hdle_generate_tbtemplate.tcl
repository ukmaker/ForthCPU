lappend auto_path "C:/lscc/diamond/3.12/data/script"
package require tbtemplate_generation

set ::bali::Para(MODNAME) core
set ::bali::Para(PROJECT) ForthCPU
set ::bali::Para(PACKAGE) {"C:/lscc/diamond/3.12/cae_library/vhdl_packages/vdbs"}
set ::bali::Para(PRIMITIVEFILE) {"C:/lscc/diamond/3.12/cae_library/synthesis/verilog/machxo3l.v"}
set ::bali::Para(TFT) {"C:/lscc/diamond/3.12/data/templates/plsitft.tft"}
set ::bali::Para(OUTNAME) core_tf
set ::bali::Para(EXT) .v
set ::bali::Para(FILELIST) {"C:/Users/Duncan/git/ForthCPU/constants.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/processorCore/source/core.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/aluGroupDecoder/source/aluGroupDecoder.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/loadStoreGroupDecoder/source/loadStoreGroupDecoder.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/instructionPhaseDecoder/source/instructionPhaseDecoder.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/programCounter/source/programCounter.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/processorCore/test/processorCoreTests.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/jumpGroupDecoder/source/jumpGroupDecoder.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registerFile.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v=work" "C:/Users/Duncan/git/ForthCPU/registerFileB/source/registers.v=work" "C:/Users/Duncan/git/ForthCPU/aluB/source/alu.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/aluB/source/aluAMux.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/aluB/source/aluBMux.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/aluB/source/fullALU.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/opxMultiplexer/source/opxMultiplexer.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/interruptLogic/source/interruptStateMachine.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/branchLogic/source/branchLogic.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/busController/source/busController.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/testSetup.v=work,Verilog_2001" "C:/Users/Duncan/git/ForthCPU/generalGroupDecoder/source/generalGroupDecoder.v=work,Verilog_2001" }
set ::bali::Para(INCLUDEPATH) {"C:/Users/Duncan/git/ForthCPU" "C:/Users/Duncan/git/ForthCPU/processorCore/source" "C:/Users/Duncan/git/ForthCPU/aluGroupDecoder/source" "C:/Users/Duncan/git/ForthCPU/loadStoreGroupDecoder/source" "C:/Users/Duncan/git/ForthCPU/instructionPhaseDecoder/source" "C:/Users/Duncan/git/ForthCPU/programCounter/source" "C:/Users/Duncan/git/ForthCPU/processorCore/test" "C:/Users/Duncan/git/ForthCPU/jumpGroupDecoder/source" "C:/Users/Duncan/git/ForthCPU/registerFileB/source" "C:/Users/Duncan/git/ForthCPU/aluB/source" "C:/Users/Duncan/git/ForthCPU/opxMultiplexer/source" "C:/Users/Duncan/git/ForthCPU/interruptLogic/source" "C:/Users/Duncan/git/ForthCPU/branchLogic/source" "C:/Users/Duncan/git/ForthCPU/busController/source" "C:/Users/Duncan/git/ForthCPU/generalGroupDecoder/source" }
puts "set parameters done"
::bali::GenerateTbTemplate
