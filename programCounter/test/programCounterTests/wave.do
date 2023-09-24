onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /programCounterTestbench/CLK
add wave -noupdate /programCounterTestbench/RESET
add wave -noupdate /programCounterTestbench/PC_EN
add wave -noupdate /programCounterTestbench/COMMIT
add wave -noupdate /programCounterTestbench/PC_D
add wave -noupdate /programCounterTestbench/JRX
add wave -noupdate /programCounterTestbench/CC_SIGN
add wave -noupdate /programCounterTestbench/CC_CARRY
add wave -noupdate /programCounterTestbench/CC_ZERO
add wave -noupdate /programCounterTestbench/CC_PARITY
add wave -noupdate /programCounterTestbench/CC_SELECTX
add wave -noupdate /programCounterTestbench/CC_INVERTX
add wave -noupdate /programCounterTestbench/CC_APPLYX
add wave -noupdate /programCounterTestbench/JMPX
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A
add wave -noupdate -radix hexadecimal /programCounterTestbench/testInstance/NEXT
add wave -noupdate -radix hexadecimal /programCounterTestbench/testInstance/SUM
add wave -noupdate -radix hexadecimal /programCounterTestbench/testInstance/OFFSET
add wave -noupdate /programCounterTestbench/testInstance/DOJMP
add wave -noupdate /programCounterTestbench/testInstance/OFFSET_SEL
add wave -noupdate /programCounterTestbench/testInstance/NEXT_SEL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {729 ns} 0} {{Cursor 2} {460 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 328
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {384 ns}
