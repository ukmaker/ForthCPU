onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /registerFileTests/CLK
add wave -noupdate /registerFileTests/RESET
add wave -noupdate -radix hexadecimal /registerFileTests/ALU_R
add wave -noupdate -radix hexadecimal /registerFileTests/DIN
add wave -noupdate -radix hexadecimal /registerFileTests/PC_A_NEXT
add wave -noupdate /registerFileTests/REGA_BYTE_EN
add wave -noupdate /registerFileTests/REGA_DINX
add wave -noupdate /registerFileTests/ARGA_X
add wave -noupdate /registerFileTests/ARGB_X
add wave -noupdate /registerFileTests/REGB_BYTE_EN
add wave -noupdate /registerFileTests/REGA_EN
add wave -noupdate /registerFileTests/REGB_EN
add wave -noupdate /registerFileTests/REGA_WEN
add wave -noupdate /registerFileTests/REGB_WEN
add wave -noupdate /registerFileTests/REGA_ADDRX
add wave -noupdate /registerFileTests/REGB_ADDRX
add wave -noupdate -radix hexadecimal /registerFileTests/REGA_DOUT
add wave -noupdate -radix hexadecimal /registerFileTests/REGB_DOUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2558051 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {2062246 ps} {3027691 ps}
