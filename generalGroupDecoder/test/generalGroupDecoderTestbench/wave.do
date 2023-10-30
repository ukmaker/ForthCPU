onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /generalGroupDecoderTests/CLK
add wave -noupdate /generalGroupDecoderTests/RESET
add wave -noupdate /generalGroupDecoderTests/DIN
add wave -noupdate /generalGroupDecoderTests/INSTRUCTION
add wave -noupdate /generalGroupDecoderTests/FETCH
add wave -noupdate /generalGroupDecoderTests/DECODE
add wave -noupdate /generalGroupDecoderTests/EXECUTE
add wave -noupdate /generalGroupDecoderTests/COMMIT
add wave -noupdate /generalGroupDecoderTests/EIX
add wave -noupdate /generalGroupDecoderTests/DIX
add wave -noupdate /generalGroupDecoderTests/RETIX
add wave -noupdate /generalGroupDecoderTests/PC_ENX
add wave -noupdate /generalGroupDecoderTests/INSTR
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
WaveRestoreZoom {0 ns} {1 us}
