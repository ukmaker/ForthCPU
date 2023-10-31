onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aluGroupDecoderTests/CLK
add wave -noupdate /aluGroupDecoderTests/RESET
add wave -noupdate /aluGroupDecoderTests/FETCH
add wave -noupdate /aluGroupDecoderTests/DECODE
add wave -noupdate /aluGroupDecoderTests/EXECUTE
add wave -noupdate /aluGroupDecoderTests/COMMIT
add wave -noupdate /aluGroupDecoderTests/DIN
add wave -noupdate /aluGroupDecoderTests/INSTRUCTION
add wave -noupdate /aluGroupDecoderTests/REGA_EN
add wave -noupdate /aluGroupDecoderTests/REGB_EN
add wave -noupdate /aluGroupDecoderTests/REGA_WEN
add wave -noupdate /aluGroupDecoderTests/REGB_WEN
add wave -noupdate /aluGroupDecoderTests/REGA_ADDRX
add wave -noupdate /aluGroupDecoderTests/REGB_ADDRX
add wave -noupdate /aluGroupDecoderTests/ALU_OPX
add wave -noupdate /aluGroupDecoderTests/ALUA_SRCX
add wave -noupdate /aluGroupDecoderTests/ALUB_SRCX
add wave -noupdate /aluGroupDecoderTests/CCL_LD
add wave -noupdate /aluGroupDecoderTests/ARGA_X
add wave -noupdate /aluGroupDecoderTests/ARGB_X
add wave -noupdate /aluGroupDecoderTests/LDSINCF
add wave -noupdate /aluGroupDecoderTests/PC_ENX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10848 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
configure wave -valuecolwidth 219
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
WaveRestoreZoom {0 ns} {11642 ns}
