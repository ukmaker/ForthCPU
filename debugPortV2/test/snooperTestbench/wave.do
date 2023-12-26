onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /snooperTests/CLK
add wave -noupdate /snooperTests/RESET
add wave -noupdate /snooperTests/FETCH
add wave -noupdate /snooperTests/DECODE
add wave -noupdate /snooperTests/EXECUTE
add wave -noupdate /snooperTests/COMMIT
add wave -noupdate -radix hexadecimal /snooperTests/DIN
add wave -noupdate -radix hexadecimal /snooperTests/ADDR
add wave -noupdate /snooperTests/RD
add wave -noupdate /snooperTests/WR
add wave -noupdate -radix hexadecimal /snooperTests/SNOOP_INST_ADDR
add wave -noupdate -radix hexadecimal /snooperTests/SNOOP_INST_DATA
add wave -noupdate -radix hexadecimal /snooperTests/SNOOP_ARG_ADDR
add wave -noupdate -radix hexadecimal /snooperTests/SNOOP_ARG_DATA
add wave -noupdate /snooperTests/SNOOP_ARG_VALID
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1200 ns} 0} {{Cursor 2} {797 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 268
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
WaveRestoreZoom {0 ns} {1976 ns}
