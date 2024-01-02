onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /watcherTests/CLK
add wave -noupdate /watcherTests/RESET
add wave -noupdate /watcherTests/FETCH
add wave -noupdate /watcherTests/DECODE
add wave -noupdate /watcherTests/EXECUTE
add wave -noupdate /watcherTests/COMMIT
add wave -noupdate -radix hexadecimal /watcherTests/ADDR
add wave -noupdate /watcherTests/DEBUG_WATCH_ENX
add wave -noupdate -radix hexadecimal /watcherTests/DEBUG_WATCH_START_ADDR
add wave -noupdate -radix hexadecimal /watcherTests/DEBUG_WATCH_END_ADDR
add wave -noupdate /watcherTests/DEBUG_IN_WATCH
add wave -noupdate -radix hexadecimal /watcherTests/DIN
add wave -noupdate /watcherTests/RD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2406 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 401
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
WaveRestoreZoom {1313 ns} {3019 ns}
