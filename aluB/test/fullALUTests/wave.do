onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullALUTests/CLK
add wave -noupdate /fullALUTests/RESET
add wave -noupdate -radix hexadecimal /fullALUTests/ALUA_DIN
add wave -noupdate -radix hexadecimal /fullALUTests/ALUB_DIN
add wave -noupdate /fullALUTests/ALU_OPX
add wave -noupdate /fullALUTests/ALUA_SRCX
add wave -noupdate /fullALUTests/ALUB_SRCX
add wave -noupdate -radix hexadecimal /fullALUTests/ARGA_X
add wave -noupdate -radix hexadecimal /fullALUTests/ARGB_X
add wave -noupdate /fullALUTests/LDSINCF
add wave -noupdate /fullALUTests/CCL_LD
add wave -noupdate -radix hexadecimal /fullALUTests/ALU_R
add wave -noupdate /fullALUTests/CCN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 200
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
WaveRestoreZoom {52 ns} {990 ns}
