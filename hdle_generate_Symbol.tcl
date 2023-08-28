lappend auto_path "C:/lscc/diamond/3.12/data/script"
package require symbol_generation

set ::bali::Para(MODNAME) register_file
set ::bali::Para(PROJECT) ForthCPU
set ::bali::Para(PACKAGE) {"C:/lscc/diamond/3.12/cae_library/vhdl_packages/vdbs"}
set ::bali::Para(PRIMITIVEFILE) {"C:/lscc/diamond/3.12/cae_library/synthesis/verilog/machxo3l.v"}
set ::bali::Para(FILELIST) {"C:/Users/Duncan/git/ForthCPU/impl1/source/alu.v=work,System_Verilog" "C:/Users/Duncan/git/ForthCPU/impl1/source/data_sources.v=work,System_Verilog" "C:/Users/Duncan/git/ForthCPU/impl1/source/multiplier.v=work,System_Verilog" "C:/Users/Duncan/git/ForthCPU/impl1/source/registers.v=work,System_Verilog" "C:/Users/Duncan/git/ForthCPU/register.v=work,System_Verilog" "C:/Users/Duncan/git/ForthCPU/register_file.v=work,System_Verilog" }
set ::bali::Para(INCLUDEPATH) {}
puts "set parameters done"
::bali::GenerateSymbol
