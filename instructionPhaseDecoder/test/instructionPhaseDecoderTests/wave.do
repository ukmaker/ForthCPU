onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instruction_phase_decoder_testbench/FETCH
add wave -noupdate /instruction_phase_decoder_testbench/DECODE
add wave -noupdate /instruction_phase_decoder_testbench/EXECUTE
add wave -noupdate /instruction_phase_decoder_testbench/COMMIT
add wave -noupdate /instruction_phase_decoder_testbench/CLK
add wave -noupdate /instruction_phase_decoder_testbench/RESET
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 277
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
WaveRestoreZoom {0 ns} {846 ns}
