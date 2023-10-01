onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processorCoreTests/CLK
add wave -noupdate /processorCoreTests/RESET
add wave -noupdate /processorCoreTests/FETCH
add wave -noupdate /processorCoreTests/DECODE
add wave -noupdate /processorCoreTests/EXECUTE
add wave -noupdate /processorCoreTests/COMMIT
add wave -noupdate /processorCoreTests/testInstance/opxMux/GROUPF
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/PC_EN
add wave -noupdate /processorCoreTests/testInstance/pc/PC_EN
add wave -noupdate /processorCoreTests/testInstance/pc/JRX
add wave -noupdate /processorCoreTests/testInstance/pc/JMPX
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/pc/PC_A
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/JRX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/JMP_X
add wave -noupdate -color Yellow /processorCoreTests/testInstance/opxMux/ALU_ADDR_BUSX
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_ADDR_BUSX
add wave -noupdate /processorCoreTests/testInstance/opxMux/ADDR_BUSX
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_REGA_DINX
add wave -noupdate /processorCoreTests/testInstance/opxMux/REGA_DINX
add wave -noupdate /processorCoreTests/testInstance/registers/REGA_DINX
add wave -noupdate /processorCoreTests/testInstance/registers/ALU_R
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/ARGA_X
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/ARGB_X
add wave -noupdate /processorCoreTests/testInstance/registers/registers/ClockEnA
add wave -noupdate /processorCoreTests/testInstance/registers/registers/WrA
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registers/registers/DataInA
add wave -noupdate /processorCoreTests/testInstance/registers/REGA_DINX
add wave -noupdate /processorCoreTests/testInstance/registers/DINA
add wave -noupdate /processorCoreTests/testInstance/alu/incInst/ALUA_SRCX
add wave -noupdate /processorCoreTests/testInstance/alu/incInst/ALUA_CONSTX
add wave -noupdate /processorCoreTests/testInstance/alu/incInst/REGA_DOUT
add wave -noupdate /processorCoreTests/testInstance/alu/incInst/ALUA_PP
add wave -noupdate /processorCoreTests/testInstance/alu/incInst/ALUA_DIN
add wave -noupdate /processorCoreTests/testInstance/registers/registers/ClockEnB
add wave -noupdate /processorCoreTests/testInstance/registers/registers/WrB
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registers/registers/DataInB
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/REGA_DOUT
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/REGB_DOUT
add wave -noupdate -radix hexadecimal /processorCoreTests/ABUS
add wave -noupdate -radix hexadecimal /processorCoreTests/DBUS_OUT
add wave -noupdate -radix hexadecimal /processorCoreTests/DBUS_IN
add wave -noupdate /processorCoreTests/RD
add wave -noupdate /processorCoreTests/WR
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_OPX
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_LD
add wave -noupdate /processorCoreTests/testInstance/alu/aluBlockInst/ALU_R
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_DATA_BUSX
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_DATA_BUSX
add wave -noupdate /processorCoreTests/testInstance/dbusController/DATA_BUSX
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_REGA_EN
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_REGB_EN
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_REGA_WEN
add wave -noupdate /processorCoreTests/testInstance/opxMux/ALU_REGB_WEN
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_REGA_EN
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_REGB_EN
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_REGA_WEN
add wave -noupdate /processorCoreTests/testInstance/opxMux/LDS_REGB_WEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {87076 ps} 0} {{Cursor 4} {2145184 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 371
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1986544 ps}
