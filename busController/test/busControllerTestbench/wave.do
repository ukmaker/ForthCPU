onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /busControllerTests/CLK
add wave -noupdate /busControllerTests/RESET
add wave -noupdate /busControllerTests/FETCH
add wave -noupdate /busControllerTests/DECODE
add wave -noupdate /busControllerTests/EXECUTE
add wave -noupdate /busControllerTests/COMMIT
add wave -noupdate /busControllerTests/PC_A
add wave -noupdate /busControllerTests/ALU_R
add wave -noupdate /busControllerTests/ALUB_DATA
add wave -noupdate /busControllerTests/ADDR_BUSX
add wave -noupdate -radix hexadecimal /busControllerTests/ADDR_BUF
add wave -noupdate /busControllerTests/ALUA_DATA
add wave -noupdate /busControllerTests/DATA_BUSX
add wave -noupdate /busControllerTests/BYTEX
add wave -noupdate /busControllerTests/WRX
add wave -noupdate /busControllerTests/RDX
add wave -noupdate /busControllerTests/DOUT_BUF
add wave -noupdate /busControllerTests/HIGH_BYTEX
add wave -noupdate /busControllerTests/DBUS_OEN
add wave -noupdate /busControllerTests/RDN_BUF
add wave -noupdate /busControllerTests/WRN0_BUF
add wave -noupdate /busControllerTests/WRN1_BUF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1970 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {1768 ns} {2396 ns}
