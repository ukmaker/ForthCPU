onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UARTTests/DIN
add wave -noupdate /UARTTests/DOUT0
add wave -noupdate /UARTTests/DOUT1
add wave -noupdate /UARTTests/CLK
add wave -noupdate /UARTTests/RESET
add wave -noupdate /UARTTests/ADDR
add wave -noupdate /UARTTests/RD0
add wave -noupdate /UARTTests/WR0
add wave -noupdate /UARTTests/INT0
add wave -noupdate /UARTTests/RD1
add wave -noupdate /UARTTests/WR1
add wave -noupdate /UARTTests/INT1
add wave -noupdate /UARTTests/RXD
add wave -noupdate /UARTTests/TXD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6621 ns} 0}
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
WaveRestoreZoom {0 ns} {6632 ns}
