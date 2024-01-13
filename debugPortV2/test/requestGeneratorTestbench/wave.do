onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /requestGeneratorTests/CLK
add wave -noupdate /requestGeneratorTests/RESET
add wave -noupdate /requestGeneratorTests/DEBUG_WR
add wave -noupdate /requestGeneratorTests/DEBUG_RD
add wave -noupdate /requestGeneratorTests/EN_MODE
add wave -noupdate /requestGeneratorTests/DEBUG_MODE_REQ_BIT
add wave -noupdate /requestGeneratorTests/EN_MRDH
add wave -noupdate /requestGeneratorTests/DEBUGX
add wave -noupdate /requestGeneratorTests/DEBUG_OP_INCX
add wave -noupdate /requestGeneratorTests/DEBUG_ACK
add wave -noupdate /requestGeneratorTests/DEBUG_REQ
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/RESET
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/SLOWCLK
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/EN
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/LD
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/FASTCLK
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/CLR
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/D
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/Q
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/Q_R
add wave -noupdate /requestGeneratorTests/testInst/modeReqReg/Q_PHI0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {547 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 348
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
WaveRestoreZoom {0 ns} {1323 ns}
