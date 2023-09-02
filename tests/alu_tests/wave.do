onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/arga
add wave -noupdate /testbench/argb
add wave -noupdate /testbench/opcode
add wave -noupdate /testbench/result
add wave -noupdate /testbench/carry
add wave -noupdate /testbench/zero
add wave -noupdate /testbench/parity
add wave -noupdate /testbench/sign
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {258 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {50 ns} {1050 ns}
