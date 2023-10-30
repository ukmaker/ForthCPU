onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /GPIOTests/CLK_X1
add wave -noupdate /GPIOTests/RESETN
add wave -noupdate /GPIOTests/DIPSW
add wave -noupdate /GPIOTests/LED
add wave -noupdate /GPIOTests/RD_GPIO
add wave -noupdate /GPIOTests/WR_GPIO
add wave -noupdate /GPIOTests/GPO
add wave -noupdate /GPIOTests/GPI
add wave -noupdate /GPIOTests/CLK
add wave -noupdate /GPIOTests/RESET
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0} {{Cursor 2} {450 ns} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 ns} {1 us}
