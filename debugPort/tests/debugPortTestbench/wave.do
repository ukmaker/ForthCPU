onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /debugPortTests/CLK
add wave -noupdate /debugPortTests/RESET
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_DIN
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_DOUT
add wave -noupdate /debugPortTests/DEBUG_ADDR
add wave -noupdate /debugPortTests/DEBUG_RD
add wave -noupdate /debugPortTests/DEBUG_WR
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_MEM_ADDR
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_MEM_DATA_OUT
add wave -noupdate /debugPortTests/testInstance/EN_MAH
add wave -noupdate /debugPortTests/testInstance/dataOutReg/LD
add wave -noupdate /debugPortTests/testInstance/dataOutReg/EN
add wave -noupdate -radix hexadecimal /debugPortTests/testInstance/dataOutReg/DIN
add wave -noupdate -radix hexadecimal /debugPortTests/testInstance/dataOutReg/DOUT
add wave -noupdate /debugPortTests/DEBUG_REQX
add wave -noupdate /debugPortTests/DEBUG_ACKX
add wave -noupdate /debugPortTests/DEBUG_OPX
add wave -noupdate /debugPortTests/DEBUG_REGX
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_DIN_DIN
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_REGA_DATA
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_CC_DATA
add wave -noupdate -radix hexadecimal /debugPortTests/DEBUG_PC_A_NEXT
add wave -noupdate /debugPortTests/DEBUG_DOUT_LDX
add wave -noupdate /debugPortTests/testInstance/requestGen/CLK
add wave -noupdate /debugPortTests/testInstance/requestGen/RESET
add wave -noupdate /debugPortTests/testInstance/requestGen/WR
add wave -noupdate /debugPortTests/testInstance/requestGen/RD
add wave -noupdate /debugPortTests/testInstance/requestGen/ACKX
add wave -noupdate /debugPortTests/testInstance/requestGen/EN_OP
add wave -noupdate /debugPortTests/testInstance/requestGen/EN_MDH
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 528
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
WaveRestoreZoom {8296 ns} {15998 ns}
