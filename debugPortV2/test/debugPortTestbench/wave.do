onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /debugPortTests/DEBUG_DIN
add wave -noupdate /debugPortTests/DEBUG_REG_ADDR
add wave -noupdate /debugPortTests/DEBUG_RDN
add wave -noupdate /debugPortTests/DEBUG_WRN
add wave -noupdate /debugPortTests/DEBUG_DOUT
add wave -noupdate /debugPortTests/CLK
add wave -noupdate /debugPortTests/RESETN
add wave -noupdate /debugPortTests/RD
add wave -noupdate /debugPortTests/WR
add wave -noupdate /debugPortTests/ADDR
add wave -noupdate /debugPortTests/RESET
add wave -noupdate /debugPortTests/DEBUG_MODE_STOP
add wave -noupdate /debugPortTests/DEBUG_REQ
add wave -noupdate /debugPortTests/DEBUG_ACK
add wave -noupdate /debugPortTests/DEBUG_DATA_OUT_SELX
add wave -noupdate /debugPortTests/DEBUG_ADDR_INCX
add wave -noupdate /debugPortTests/DEBUG_SNOOP_LD_EN
add wave -noupdate /debugPortTests/DEBUG_BKP_ENX
add wave -noupdate /debugPortTests/DEBUG_WATCH_ENX
add wave -noupdate /debugPortTests/DEBUG_IN_WATCH
add wave -noupdate /debugPortTests/DEBUG_AT_BKP
add wave -noupdate /debugPortTests/DEBUG_DATA_IN
add wave -noupdate /debugPortTests/DEBUG_ADDR_IN
add wave -noupdate /debugPortTests/DEBUG_ADDR_OUT
add wave -noupdate /debugPortTests/DEBUG_DATA_OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1354 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
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
WaveRestoreZoom {0 ps} {2736 ps}
