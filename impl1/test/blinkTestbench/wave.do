onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /blinkTests/PIN_CLK_X1
add wave -noupdate /blinkTests/PIN_RESETN
add wave -noupdate /blinkTests/FETCH
add wave -noupdate /blinkTests/DECODE
add wave -noupdate /blinkTests/EXECUTE
add wave -noupdate /blinkTests/COMMIT
add wave -noupdate -radix hexadecimal /blinkTests/PIN_ADDR_BUS
add wave -noupdate -radix hexadecimal /blinkTests/PIN_DATA_BUS
add wave -noupdate /blinkTests/PIN_INT0
add wave -noupdate /blinkTests/PIN_INT1
add wave -noupdate /blinkTests/PIN_INT2
add wave -noupdate /blinkTests/PIN_INT3
add wave -noupdate /blinkTests/PIN_INT4
add wave -noupdate /blinkTests/PIN_INT5
add wave -noupdate /blinkTests/PIN_INT6
add wave -noupdate /blinkTests/PIN_RDN
add wave -noupdate /blinkTests/PIN_WR0N
add wave -noupdate /blinkTests/PIN_WR1N
add wave -noupdate /blinkTests/PIN_RXD
add wave -noupdate /blinkTests/PIN_TXD
add wave -noupdate /blinkTests/PIN_DIPSW
add wave -noupdate /blinkTests/PIN_LED
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/ROMInst/Address
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/ROMInst/Q
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/aluInst/ARGA
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/aluInst/ARGB
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/aluInst/RESULT
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/aluInst/ZERO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8570864 ps} 0} {{Cursor 2} {8330973 ps} 0}
quietly wave cursor active 2
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
configure wave -timelineunits ps
update
WaveRestoreZoom {7606142 ps} {8824590 ps}
