onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /register_file_testbench/DIN
add wave -noupdate /register_file_testbench/REGAX
add wave -noupdate /register_file_testbench/REGBX
add wave -noupdate /register_file_testbench/REGAOPX
add wave -noupdate /register_file_testbench/REGBOPX
add wave -noupdate /register_file_testbench/CLK
add wave -noupdate /register_file_testbench/RESETN
add wave -noupdate -radix hexadecimal /register_file_testbench/DOUT_A
add wave -noupdate -radix hexadecimal /register_file_testbench/DOUT_B
add wave -noupdate -radix hexadecimal /register_file_testbench/DOUT_PC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {254 ns} 0} {{Cursor 2} {162 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 300
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
WaveRestoreZoom {112 ns} {312 ns}
