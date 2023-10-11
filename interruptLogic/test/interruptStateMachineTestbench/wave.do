onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /interruptStateMachineTests/CLK
add wave -noupdate /interruptStateMachineTests/RESET
add wave -noupdate /interruptStateMachineTests/COMMIT
add wave -noupdate /interruptStateMachineTests/RETIX
add wave -noupdate /interruptStateMachineTests/EIX
add wave -noupdate /interruptStateMachineTests/DIX
add wave -noupdate /interruptStateMachineTests/INT0
add wave -noupdate /interruptStateMachineTests/INT1
add wave -noupdate /interruptStateMachineTests/PC_NEXTX
add wave -noupdate /interruptStateMachineTests/PC_LD_INT0
add wave -noupdate /interruptStateMachineTests/PC_LD_INT1
add wave -noupdate -radix hexadecimal /interruptStateMachineTests/testInstance/STATE
add wave -noupdate -radix hexadecimal /interruptStateMachineTests/testInstance/STATE_NEXT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2861 ns} 0} {{Cursor 2} {1669 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
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
WaveRestoreZoom {0 ns} {2854 ns}
