onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processorCoreInterruptTests/CLK
add wave -noupdate /processorCoreInterruptTests/RESET
add wave -noupdate /processorCoreInterruptTests/FETCH
add wave -noupdate /processorCoreInterruptTests/DECODE
add wave -noupdate /processorCoreInterruptTests/EXECUTE
add wave -noupdate /processorCoreInterruptTests/COMMIT
add wave -noupdate /processorCoreInterruptTests/INT0
add wave -noupdate /processorCoreInterruptTests/INT1
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/testInstance/programCounterInst/PC_A
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/testInstance/programCounterInst/PC_A_NEXT
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/testInstance/programCounterInst/HERE
add wave -noupdate /processorCoreInterruptTests/testInstance/programCounterInst/PC_BASEX
add wave -noupdate /processorCoreInterruptTests/testInstance/programCounterInst/PC_OFFSETX
add wave -noupdate /processorCoreInterruptTests/testInstance/loadStoreGroupDecoderInst/PC_OFFSETX
add wave -noupdate /processorCoreInterruptTests/testInstance/opxMultiplexerInst/PC_OFFSETX_R
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/ADDR_BUF
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/DOUT_BUF
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/DIN
add wave -noupdate /processorCoreInterruptTests/RDN_BUF
add wave -noupdate /processorCoreInterruptTests/WRN0_BUF
add wave -noupdate /processorCoreInterruptTests/WRN1_BUF
add wave -noupdate /processorCoreInterruptTests/ABUS_OEN
add wave -noupdate -radix hexadecimal /processorCoreInterruptTests/INSTR
add wave -noupdate /processorCoreInterruptTests/U6
add wave -noupdate /processorCoreInterruptTests/U2
add wave -noupdate /processorCoreInterruptTests/U4
add wave -noupdate /processorCoreInterruptTests/doInt0
add wave -noupdate /processorCoreInterruptTests/doInt1
add wave -noupdate /processorCoreInterruptTests/testInstance/loadStoreGroupDecoderInst/ADDR_BUSX
add wave -noupdate /processorCoreInterruptTests/testInstance/opxMultiplexerInst/ADDR_BUSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4553122 ps} 0} {{Cursor 2} {1397785 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 486
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
WaveRestoreZoom {0 ps} {1707912 ps}
