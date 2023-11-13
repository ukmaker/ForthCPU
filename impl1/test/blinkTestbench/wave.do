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
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/fullALUInst/ALUA_DATA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/fullALUInst/ALUB_DATA
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/CC_ZERO
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/CC_CARRY
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/CC_SIGN
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/CC_PARITY
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/DataInA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/DataInB
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/ByteEnA
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/ByteEnB
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/AddressA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/AddressB
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/ClockEnA
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/ClockEnB
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/WrA
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/regs/WrB
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/QA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/QB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4589421642 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 355
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
WaveRestoreZoom {4588797561 ps} {4591187335 ps}
