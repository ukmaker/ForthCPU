onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /programCounterTestbench/CLK
add wave -noupdate /programCounterTestbench/RESET
add wave -noupdate /programCounterTestbench/FETCH
add wave -noupdate /programCounterTestbench/DECODE
add wave -noupdate /programCounterTestbench/EXECUTE
add wave -noupdate /programCounterTestbench/COMMIT
add wave -noupdate -radix hexadecimal /programCounterTestbench/INSTRUCTION
add wave -noupdate /programCounterTestbench/PC_EN
add wave -noupdate /programCounterTestbench/JRX
add wave -noupdate /programCounterTestbench/JMP_X
add wave -noupdate /programCounterTestbench/CC_APPLYX
add wave -noupdate /programCounterTestbench/CC_INVERTX
add wave -noupdate /programCounterTestbench/CC_SELECTX
add wave -noupdate /programCounterTestbench/REGB_ADDRX
add wave -noupdate /programCounterTestbench/ALUB_SRCX
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_D
add wave -noupdate /programCounterTestbench/CC_SIGN
add wave -noupdate /programCounterTestbench/CC_CARRY
add wave -noupdate /programCounterTestbench/CC_ZERO
add wave -noupdate /programCounterTestbench/CC_PARITY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {958 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
configure wave -valuecolwidth 103
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
WaveRestoreZoom {0 ns} {2100 ns}
