onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memoryMapperTests/CLK
add wave -noupdate /memoryMapperTests/RESET
add wave -noupdate /memoryMapperTests/RDN
add wave -noupdate /memoryMapperTests/WR0N
add wave -noupdate /memoryMapperTests/WR1N
add wave -noupdate /memoryMapperTests/ADDR
add wave -noupdate /memoryMapperTests/CPU_DIN
add wave -noupdate /memoryMapperTests/DIN_BUS
add wave -noupdate /memoryMapperTests/DIN_ROM
add wave -noupdate /memoryMapperTests/DIN_RAM
add wave -noupdate /memoryMapperTests/DIN_UART
add wave -noupdate /memoryMapperTests/DIN_INT
add wave -noupdate /memoryMapperTests/RD_UART
add wave -noupdate /memoryMapperTests/WR_UART
add wave -noupdate /memoryMapperTests/ADDR_UART
add wave -noupdate /memoryMapperTests/RD_INT
add wave -noupdate /memoryMapperTests/WR_INT
add wave -noupdate /memoryMapperTests/ADDR_INT
add wave -noupdate /memoryMapperTests/BE0
add wave -noupdate /memoryMapperTests/BE1
add wave -noupdate /memoryMapperTests/testInstance/WRITE
add wave -noupdate /memoryMapperTests/WR_RAM
add wave -noupdate /memoryMapperTests/EN_RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1768360 ps} 0} {{Cursor 2} {18750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 362
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
WaveRestoreZoom {851851 ps} {2472487 ps}
