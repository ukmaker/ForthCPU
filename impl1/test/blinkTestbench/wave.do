onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /blinkTests/PIN_CLK_X1
add wave -noupdate /blinkTests/PIN_RESETN
add wave -noupdate /blinkTests/FETCH
add wave -noupdate /blinkTests/DECODE
add wave -noupdate /blinkTests/EXECUTE
add wave -noupdate /blinkTests/COMMIT
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/busControllerInst/ADDR_BUSX
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/busControllerInst/ALU_R
add wave -noupdate /blinkTests/mcuInst/coreInst/fullALUInst/ALUB_SRCX
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/fullALUInst/REGB_DOUT
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/busControllerInst/ALUB_DATA
add wave -noupdate -radix hexadecimal /blinkTests/PIN_ADDR_BUS
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/DIN
add wave -noupdate -radix hexadecimal /blinkTests/PIN_DATA_BUS
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/memoryMapperInst/RAM_MAP
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/RAMInst/Clock
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/RAMInst/ClockEn
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/RAMInst/ByteEn
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/RAMInst/Address
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/RAMInst/Data
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/RAMInst/Q
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
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/UARTInst/RD
add wave -noupdate /blinkTests/mcuInst/mcuResourcesInst/UARTInst/WR
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/UARTInst/DIN
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/mcuResourcesInst/UARTInst/DOUT
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/REGA_EN
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/REGA_WEN
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/ADDRA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/DataInA
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/QA
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/REGB_EN
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/REGB_WEN
add wave -noupdate /blinkTests/mcuInst/coreInst/registerFileInst/ADDRB
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/DataInB
add wave -noupdate -radix hexadecimal /blinkTests/mcuInst/coreInst/registerFileInst/regs/QB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2052567 ps} 0} {{Cursor 2} {11246227 ps} 0} {{Cursor 3} {11651902 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 354
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
WaveRestoreZoom {0 ps} {811348 ps}
