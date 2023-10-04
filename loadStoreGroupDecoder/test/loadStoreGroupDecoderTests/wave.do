onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /loadStoreGroupDecoderTests/CLK
add wave -noupdate /loadStoreGroupDecoderTests/RESET
add wave -noupdate -radix hexadecimal /loadStoreGroupDecoderTests/INSTRUCTION
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
add wave -noupdate /loadStoreGroupDecoderTests/REGB_DINX
add wave -noupdate /loadStoreGroupDecoderTests/REGA_ADDRX
add wave -noupdate /loadStoreGroupDecoderTests/REGB_ADDRX
add wave -noupdate /loadStoreGroupDecoderTests/REGA_BYTE_ENX
add wave -noupdate /loadStoreGroupDecoderTests/REGB_BYTE_ENX
add wave -noupdate /loadStoreGroupDecoderTests/DATA_BUSX
add wave -noupdate /loadStoreGroupDecoderTests/DATA_BUS_OEN
add wave -noupdate /loadStoreGroupDecoderTests/ADDR_BUSX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160 ns} 0} {{Cursor 2} {549 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 298
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
WaveRestoreZoom {0 ns} {1324 ns}
