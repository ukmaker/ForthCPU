onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /coreTests/CLK
add wave -noupdate /coreTests/RESET
add wave -noupdate /coreTests/STOPPED
add wave -noupdate /coreTests/FETCH
add wave -noupdate /coreTests/DECODE
add wave -noupdate /coreTests/EXECUTE
add wave -noupdate /coreTests/COMMIT
add wave -noupdate /coreTests/testArticle/busInterfaceInst/BUS_SEQX
add wave -noupdate /coreTests/testArticle/busInterfaceInst/DATA_BUSX
add wave -noupdate -radix hexadecimal /coreTests/INSTR
add wave -noupdate /coreTests/testArticle/registerSequencerInst/REGA_EN
add wave -noupdate /coreTests/testArticle/registerSequencerInst/REGB_EN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGA_EN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGA_WEN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGB_EN
add wave -noupdate /coreTests/testArticle/registerFileInst/REGB_WEN
add wave -noupdate /coreTests/testArticle/registerFileInst/ADDRA
add wave -noupdate /coreTests/testArticle/registerFileInst/ADDRB
add wave -noupdate -radix hexadecimal /coreTests/testArticle/busInterfaceInst/REGA_DOUT
add wave -noupdate -radix hexadecimal -childformat {{{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[15]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[14]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[13]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[12]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[11]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[10]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[9]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[8]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[7]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[6]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[5]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[4]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[3]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[2]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[1]} -radix hexadecimal} {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[0]} -radix hexadecimal}} -subitemconfig {{/coreTests/testArticle/busInterfaceInst/REGB_DOUT[15]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[14]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[13]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[12]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[11]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[10]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[9]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[8]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[7]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[6]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[5]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[4]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[3]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[2]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[1]} {-height 15 -radix hexadecimal} {/coreTests/testArticle/busInterfaceInst/REGB_DOUT[0]} {-height 15 -radix hexadecimal}} /coreTests/testArticle/busInterfaceInst/REGB_DOUT
add wave -noupdate /coreTests/testArticle/busInterfaceInst/BYTEX
add wave -noupdate /coreTests/testArticle/busInterfaceInst/HIGH_BYTEX
add wave -noupdate /coreTests/testArticle/busInterfaceInst/ADDR_BUSX
add wave -noupdate -radix hexadecimal /coreTests/DIN
add wave -noupdate -radix hexadecimal /coreTests/DIN_BUF
add wave -noupdate -radix hexadecimal /coreTests/DOUT_BUF
add wave -noupdate -radix hexadecimal /coreTests/ADDR_BUF
add wave -noupdate /coreTests/WRN0_BUF
add wave -noupdate /coreTests/WRN1_BUF
add wave -noupdate /coreTests/RDN_BUF
add wave -noupdate /coreTests/WR0_BUF
add wave -noupdate /coreTests/WR1_BUF
add wave -noupdate /coreTests/RD_BUF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7400000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 318
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
WaveRestoreZoom {8698068 ps} {10068523 ps}
