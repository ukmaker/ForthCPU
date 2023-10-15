onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processorCoreInstructionTests/CLK
add wave -noupdate /processorCoreInstructionTests/RESET
add wave -noupdate /processorCoreInstructionTests/FETCH
add wave -noupdate /processorCoreInstructionTests/DECODE
add wave -noupdate /processorCoreInstructionTests/EXECUTE
add wave -noupdate /processorCoreInstructionTests/COMMIT
add wave -noupdate /processorCoreInstructionTests/INT0
add wave -noupdate /processorCoreInstructionTests/INT1
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/ADDR_BUF
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/DOUT_BUF
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/DIN
add wave -noupdate /processorCoreInstructionTests/RD
add wave -noupdate /processorCoreInstructionTests/WR
add wave -noupdate /processorCoreInstructionTests/RDN_BUF
add wave -noupdate /processorCoreInstructionTests/WRN0_BUF
add wave -noupdate /processorCoreInstructionTests/WRN1_BUF
add wave -noupdate /processorCoreInstructionTests/ABUS_OEN
add wave -noupdate /processorCoreInstructionTests/DBUS_OEN
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/INSTR
add wave -noupdate /processorCoreInstructionTests/testInstance/registerFileInst/regs/ClockEnA
add wave -noupdate /processorCoreInstructionTests/testInstance/registerFileInst/regs/WrA
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/AddressA
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/DataInA
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/QA
add wave -noupdate /processorCoreInstructionTests/testInstance/registerFileInst/regs/ClockEnB
add wave -noupdate /processorCoreInstructionTests/testInstance/registerFileInst/regs/WrB
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/AddressB
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/DataInB
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/registerFileInst/regs/QB
add wave -noupdate /processorCoreInstructionTests/testInstance/aluGroupDecoderInst/RD_A
add wave -noupdate /processorCoreInstructionTests/testInstance/aluGroupDecoderInst/REGA_EN
add wave -noupdate /processorCoreInstructionTests/testInstance/aluGroupDecoderInst/RD_B
add wave -noupdate /processorCoreInstructionTests/testInstance/aluGroupDecoderInst/REGB_EN
add wave -noupdate /processorCoreInstructionTests/testInstance/fullALUInst/ALUA_SRCX
add wave -noupdate /processorCoreInstructionTests/testInstance/fullALUInst/ALUB_SRCX
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/fullALUInst/aluInst/ARGA
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/fullALUInst/aluInst/ARGB
add wave -noupdate -radix hexadecimal /processorCoreInstructionTests/testInstance/fullALUInst/aluInst/RESULT
add wave -noupdate /processorCoreInstructionTests/testInstance/opxMultiplexerInst/ALU_REGA_EN
add wave -noupdate /processorCoreInstructionTests/testInstance/opxMultiplexerInst/REGA_EN
add wave -noupdate /processorCoreInstructionTests/testInstance/opxMultiplexerInst/ALU_REGB_EN
add wave -noupdate /processorCoreInstructionTests/testInstance/opxMultiplexerInst/REGB_EN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11251462 ps} 0} {{Cursor 2} {17362553 ps} 0} {{Cursor 3} {12450803 ps} 0} {{Cursor 4} {12252190 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 432
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
WaveRestoreZoom {11116225 ps} {12549881 ps}
