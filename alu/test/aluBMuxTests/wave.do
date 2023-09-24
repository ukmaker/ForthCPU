onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aluBMuxTests/REGB_DOUT
add wave -noupdate /aluBMuxTests/ARGA_X
add wave -noupdate /aluBMuxTests/ARGB_X
add wave -noupdate /aluBMuxTests/LDS_SRCX
add wave -noupdate /aluBMuxTests/ALUB_SRCX
add wave -noupdate /aluBMuxTests/CLK
add wave -noupdate /aluBMuxTests/ARGB
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
