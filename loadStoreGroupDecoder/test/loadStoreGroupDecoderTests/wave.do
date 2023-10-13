onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /loadStoreGroupDecoderTests/CLK
add wave -noupdate /loadStoreGroupDecoderTests/RESET
add wave -noupdate /loadStoreGroupDecoderTests/INSTRUCTION
add wave -noupdate /loadStoreGroupDecoderTests/FETCH
add wave -noupdate /loadStoreGroupDecoderTests/DECODE
add wave -noupdate /loadStoreGroupDecoderTests/EXECUTE
add wave -noupdate /loadStoreGroupDecoderTests/COMMIT
add wave -noupdate /loadStoreGroupDecoderTests/REGA_EN
add wave -noupdate /loadStoreGroupDecoderTests/REGB_EN
add wave -noupdate /loadStoreGroupDecoderTests/REGA_WEN
add wave -noupdate /loadStoreGroupDecoderTests/REGB_WEN
add wave -noupdate /loadStoreGroupDecoderTests/ALU_OPX
add wave -noupdate /loadStoreGroupDecoderTests/ALUA_SRCX
add wave -noupdate /loadStoreGroupDecoderTests/ALUB_SRCX
add wave -noupdate /loadStoreGroupDecoderTests/REGA_DINX
add wave -noupdate /loadStoreGroupDecoderTests/REGA_ADDRX
add wave -noupdate /loadStoreGroupDecoderTests/REGB_ADDRX
add wave -noupdate /loadStoreGroupDecoderTests/REGA_BYTE_ENX
add wave -noupdate /loadStoreGroupDecoderTests/REGB_BYTE_ENX
add wave -noupdate /loadStoreGroupDecoderTests/DATA_BUSX
add wave -noupdate /loadStoreGroupDecoderTests/RDX
add wave -noupdate /loadStoreGroupDecoderTests/WRX
add wave -noupdate /loadStoreGroupDecoderTests/BYTEX
add wave -noupdate /loadStoreGroupDecoderTests/ADDR_BUSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1933 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
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
WaveRestoreZoom {622 ns} {4158 ns}
