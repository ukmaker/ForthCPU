onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /interruptMaskRegisterTests/CLK
add wave -noupdate /interruptMaskRegisterTests/RESET
add wave -noupdate /interruptMaskRegisterTests/DIN
add wave -noupdate /interruptMaskRegisterTests/RD
add wave -noupdate /interruptMaskRegisterTests/ADDR
add wave -noupdate /interruptMaskRegisterTests/INTS1
add wave -noupdate /interruptMaskRegisterTests/INTS2
add wave -noupdate /interruptMaskRegisterTests/INTS3
add wave -noupdate /interruptMaskRegisterTests/INTS4
add wave -noupdate /interruptMaskRegisterTests/INTS5
add wave -noupdate /interruptMaskRegisterTests/INTS6
add wave -noupdate /interruptMaskRegisterTests/INTS7
add wave -noupdate -radix hexadecimal /interruptMaskRegisterTests/DOUT
add wave -noupdate /interruptMaskRegisterTests/INT1
add wave -noupdate /interruptMaskRegisterTests/WR
add wave -noupdate /interruptMaskRegisterTests/testInst/MASK_REG
add wave -noupdate /interruptMaskRegisterTests/testInst/INTS_REG
add wave -noupdate /interruptMaskRegisterTests/testInst/PRI_REG
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0} {{Cursor 2} {1061 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 288
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
WaveRestoreZoom {0 ns} {1649 ns}
