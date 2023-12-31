onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /programCounterTestbench/CLK
add wave -noupdate /programCounterTestbench/RESET
add wave -noupdate /programCounterTestbench/STOPPED
add wave -noupdate /programCounterTestbench/FETCH
add wave -noupdate /programCounterTestbench/DECODE
add wave -noupdate /programCounterTestbench/EXECUTE
add wave -noupdate /programCounterTestbench/COMMIT
add wave -noupdate /programCounterTestbench/HALTX
add wave -noupdate /programCounterTestbench/DEBUG_MODE
add wave -noupdate /programCounterTestbench/DEBUG_STOP
add wave -noupdate /programCounterTestbench/DEBUG_STEP_REQ
add wave -noupdate /programCounterTestbench/DEBUG_LD_BKP_EN
add wave -noupdate /programCounterTestbench/DEBUG_EN_BKPX
add wave -noupdate /programCounterTestbench/DEBUG_AT_BKP
add wave -noupdate /programCounterTestbench/testInst/BKP_ACTIVE
add wave -noupdate /programCounterTestbench/PC_LD_INT0X
add wave -noupdate /programCounterTestbench/PC_LD_INT1X
add wave -noupdate /programCounterTestbench/PC_BASEX
add wave -noupdate /programCounterTestbench/PC_OFFSETX
add wave -noupdate /programCounterTestbench/PC_NEXTX
add wave -noupdate -radix hexadecimal /programCounterTestbench/DIN_BKP
add wave -noupdate -radix hexadecimal /programCounterTestbench/REGB_DOUT
add wave -noupdate -radix hexadecimal /programCounterTestbench/DIN
add wave -noupdate -radix hexadecimal /programCounterTestbench/HERE
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A_NEXT
add wave -noupdate -radix hexadecimal /programCounterTestbench/PC_A
add wave -noupdate /programCounterTestbench/DEBUG_STEP_ACK
add wave -noupdate /programCounterTestbench/PC_ENX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5459 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
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
WaveRestoreZoom {4737 ns} {7545 ns}
