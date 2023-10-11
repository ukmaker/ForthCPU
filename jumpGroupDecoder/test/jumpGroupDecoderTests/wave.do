onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jumpGroupDecoderTests/CLK
add wave -noupdate /jumpGroupDecoderTests/RESET
add wave -noupdate /jumpGroupDecoderTests/FETCH
add wave -noupdate /jumpGroupDecoderTests/DECODE
add wave -noupdate /jumpGroupDecoderTests/EXECUTE
add wave -noupdate /jumpGroupDecoderTests/COMMIT
add wave -noupdate /jumpGroupDecoderTests/INSTRUCTION
add wave -noupdate /jumpGroupDecoderTests/PC_EN
add wave -noupdate /jumpGroupDecoderTests/JRX
add wave -noupdate /jumpGroupDecoderTests/JMP_X
add wave -noupdate /jumpGroupDecoderTests/CC_APPLYX
add wave -noupdate /jumpGroupDecoderTests/CC_INVERTX
add wave -noupdate /jumpGroupDecoderTests/CC_SELECTX
add wave -noupdate /jumpGroupDecoderTests/REGB_ADDRX
add wave -noupdate /jumpGroupDecoderTests/ALUB_SRCX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {998 ns}
