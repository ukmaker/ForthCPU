onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processorCoreTests/CLK
add wave -noupdate /processorCoreTests/RESET
add wave -noupdate /processorCoreTests/FETCH
add wave -noupdate /processorCoreTests/DECODE
add wave -noupdate /processorCoreTests/EXECUTE
add wave -noupdate /processorCoreTests/COMMIT
add wave -noupdate -radix hexadecimal /processorCoreTests/ABUS
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/pc/PC_A
add wave -noupdate /processorCoreTests/DBUS_OUT
add wave -noupdate /processorCoreTests/DBUS_IN
add wave -noupdate /processorCoreTests/testInstance/pc/PC_D
add wave -noupdate /processorCoreTests/RD
add wave -noupdate /processorCoreTests/WR
add wave -noupdate /processorCoreTests/testInstance/ipd/RESET
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/PC_EN
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/JRX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/JMP_X
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/CC_APPLYX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/CC_INVERTX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/CC_SELECTX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/REGB_ADDRX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/ALUB_SRCX
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/GROUPF
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/SKIPF
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/JPF
add wave -noupdate /processorCoreTests/testInstance/pcDecoder/CCF
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/REGA_EN
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/REGA_WEN
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/REGB_EN
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/REGB_WEN
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/ALUA_SRCX
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/ALUB_SRCX
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/DATA_BUSX
add wave -noupdate /processorCoreTests/testInstance/ldsDecoder/ADDR_BUSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {468904 ps} 0} {{Cursor 2} {847192 ps} 0} {{Cursor 3} {1250036 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 389
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
WaveRestoreZoom {230179 ps} {1392371 ps}
