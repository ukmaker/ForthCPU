onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /requestGeneratorTests/CLK
add wave -noupdate /requestGeneratorTests/RESET
add wave -noupdate /requestGeneratorTests/WR
add wave -noupdate /requestGeneratorTests/RD
add wave -noupdate /requestGeneratorTests/ACKX
add wave -noupdate /requestGeneratorTests/EN_OP
add wave -noupdate /requestGeneratorTests/EN_MDH
add wave -noupdate /requestGeneratorTests/REQX
add wave -noupdate /requestGeneratorTests/testInstance/RD_REQ_R
add wave -noupdate /requestGeneratorTests/testInstance/WR_REQ_R
add wave -noupdate /requestGeneratorTests/testInstance/REQ_PHI0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1584 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 359
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
WaveRestoreZoom {0 ns} {4925 ns}
