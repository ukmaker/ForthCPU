onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /coreTests/CLK
add wave -noupdate /coreTests/RESET
add wave -noupdate /coreTests/STOPPED
add wave -noupdate /coreTests/FETCH
add wave -noupdate /coreTests/DECODE
add wave -noupdate /coreTests/EXECUTE
add wave -noupdate /coreTests/COMMIT
add wave -noupdate /coreTests/RDN_BUF
add wave -noupdate -radix hexadecimal /coreTests/DIN
add wave -noupdate -radix hexadecimal /coreTests/DIN_BUF
add wave -noupdate -radix hexadecimal /coreTests/DOUT_BUF
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/ADDR_BUSX
add wave -noupdate -radix hexadecimal /coreTests/ADDR_BUF
add wave -noupdate /coreTests/testArticle/registerSequencerInst/REG_SEQX
add wave -noupdate /coreTests/testArticle/registerFileInst/REGA_EN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGA_WEN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGA_ADDRX
add wave -noupdate /coreTests/testArticle/registerFileInst/REGB_EN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGB_WEN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGB_ADDRX
add wave -noupdate /coreTests/testArticle/registerFileInst/ADDRA
add wave -noupdate /coreTests/testArticle/registerFileInst/ADDRB
add wave -noupdate /coreTests/WRN0_BUF
add wave -noupdate /coreTests/WRN1_BUF
add wave -noupdate -radix hexadecimal /coreTests/INSTR
add wave -noupdate /coreTests/WR0_BUF
add wave -noupdate /coreTests/WR1_BUF
add wave -noupdate /coreTests/RD_BUF
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/PC_A
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/ALU_R
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/ALUB_DATA
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/HERE
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/DEBUG_ADDR
add wave -noupdate -radix hexadecimal /coreTests/testArticle/addressBusControllerInst/ADDR
add wave -noupdate /coreTests/testArticle/programCounterInst/PC_ENX
add wave -noupdate /coreTests/testArticle/programCounterInst/PC_BASEX
add wave -noupdate /coreTests/testArticle/programCounterInst/PC_NEXTX
add wave -noupdate /coreTests/testArticle/programCounterInst/PC_OFFSETX
add wave -noupdate -radix hexadecimal /coreTests/testArticle/programCounterInst/REGB_DOUT
add wave -noupdate -radix hexadecimal /coreTests/testArticle/programCounterInst/DIN
add wave -noupdate -radix hexadecimal /coreTests/testArticle/programCounterInst/HERE
add wave -noupdate -radix hexadecimal /coreTests/testArticle/programCounterInst/PC_A_NEXT
add wave -noupdate -radix hexadecimal /coreTests/testArticle/programCounterInst/PC_A
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {206438 ps} 0} {{Cursor 2} {8914407 ps} 0} {{Cursor 3} {1149267 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 363
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
WaveRestoreZoom {8189415 ps} {9544781 ps}
