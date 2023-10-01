onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /register_file_tests/CLK
add wave -noupdate /register_file_tests/RESET
add wave -noupdate -radix hexadecimal /register_file_tests/ALU_R
add wave -noupdate -radix hexadecimal /register_file_tests/PC_A
add wave -noupdate -radix hexadecimal /register_file_tests/ALUA_PP
add wave -noupdate -radix hexadecimal /register_file_tests/DIN
add wave -noupdate /register_file_tests/REGA_EN
add wave -noupdate /register_file_tests/REGB_EN
add wave -noupdate /register_file_tests/REGA_WEN
add wave -noupdate /register_file_tests/REGB_WEN
add wave -noupdate /register_file_tests/ARGA_X
add wave -noupdate /register_file_tests/ARGB_X
add wave -noupdate /register_file_tests/REGA_ADDRX
add wave -noupdate /register_file_tests/REGA_DINX
add wave -noupdate /register_file_tests/REGB_ADDRX
add wave -noupdate -radix hexadecimal /register_file_tests/REGA_DOUT
add wave -noupdate -radix hexadecimal /register_file_tests/REGB_DOUT
add wave -noupdate /register_file_tests/rf/registers/dpram_0_0_1/DOA_reg_async
add wave -noupdate /register_file_tests/rf/registers/dpram_0_0_1/DOB_reg_async
add wave -noupdate /register_file_tests/rf/registers/dpram_0_0_1/WREA_node
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1765518 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 451
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
WaveRestoreZoom {0 ps} {1140865 ps}
