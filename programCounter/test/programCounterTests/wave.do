onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /programCounterTestbench/CLK
add wave -noupdate /programCounterTestbench/RESET
add wave -noupdate /programCounterTestbench/PC_ENX
add wave -noupdate /programCounterTestbench/FETCH
add wave -noupdate /programCounterTestbench/PC_LD_INT0X
add wave -noupdate /programCounterTestbench/PC_LD_INT1X
add wave -noupdate /programCounterTestbench/PC_BASEX
add wave -noupdate /programCounterTestbench/PC_OFFSETX
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_D
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_NEXTX
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A_NEXT
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {359 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 292
configure wave -valuecolwidth 74
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1483 ns}
