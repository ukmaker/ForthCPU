onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /coreTests/CLK
add wave -noupdate /coreTests/RESET
add wave -noupdate /coreTests/STOPPED
add wave -noupdate /coreTests/FETCH
add wave -noupdate /coreTests/DECODE
add wave -noupdate /coreTests/EXECUTE
add wave -noupdate /coreTests/COMMIT
add wave -noupdate -radix hexadecimal /coreTests/DIN
add wave -noupdate -radix hexadecimal /coreTests/DIN_BUF
add wave -noupdate -radix hexadecimal /coreTests/DOUT_BUF
add wave -noupdate -radix hexadecimal /coreTests/ADDR_BUF
add wave -noupdate /coreTests/WRN0_BUF
add wave -noupdate /coreTests/WRN1_BUF
add wave -noupdate /coreTests/RDN_BUF
add wave -noupdate -radix hexadecimal /coreTests/INSTR
add wave -noupdate /coreTests/WR0_BUF
add wave -noupdate /coreTests/WR1_BUF
add wave -noupdate /coreTests/RD_BUF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1003102 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 313
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
WaveRestoreZoom {0 ps} {3006848 ps}
