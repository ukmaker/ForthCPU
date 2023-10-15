onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processorCoreTests/CLK
add wave -noupdate /processorCoreTests/RESET
add wave -noupdate /processorCoreTests/FETCH
add wave -noupdate /processorCoreTests/testInstance/busControllerInst/ADDR_BUSX
add wave -noupdate /processorCoreTests/RDN_BUF
add wave -noupdate /processorCoreTests/WRN0_BUF
add wave -noupdate /processorCoreTests/WRN1_BUF
add wave -noupdate -radix hexadecimal /processorCoreTests/ADDR_BUF
add wave -noupdate -radix hexadecimal /processorCoreTests/DOUT_BUF
add wave -noupdate /processorCoreTests/DBUS_OEN
add wave -noupdate /processorCoreTests/DECODE
add wave -noupdate /processorCoreTests/EXECUTE
add wave -noupdate /processorCoreTests/COMMIT
add wave -noupdate /processorCoreTests/INT0
add wave -noupdate /processorCoreTests/INT1
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/REGA_EN
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/regs/ClockEnA
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/regs/WrA
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/ADDRA
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/regs/DataInA
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/regs/QA
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/REGB_EN
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/regs/WrB
add wave -noupdate /processorCoreTests/testInstance/registerFileInst/regs/ClockEnB
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/regs/DataInB
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/ADDRB
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/busControllerInst/ALUB_DATA
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/registerFileInst/regs/QB
add wave -noupdate -radix hexadecimal /processorCoreTests/DIN
add wave -noupdate -radix hexadecimal /processorCoreTests/testInstance/instructionPhaseDecoderInst/INSTRUCTION
add wave -noupdate /processorCoreTests/RD
add wave -noupdate /processorCoreTests/WR
add wave -noupdate /processorCoreTests/ABUS_OEN
add wave -noupdate -radix hexadecimal /processorCoreTests/INSTR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1595386 ps} 0} {{Cursor 2} {2048297 ps} 0} {{Cursor 3} {1201005 ps} 0} {{Cursor 4} {2403078 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 452
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
WaveRestoreZoom {1443307 ps} {4134563 ps}
