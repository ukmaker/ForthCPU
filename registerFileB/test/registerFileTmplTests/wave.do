onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb/DataInA
add wave -noupdate -radix hexadecimal /tb/DataInB
add wave -noupdate /tb/ByteEnA
add wave -noupdate /tb/ByteEnB
add wave -noupdate /tb/AddressA
add wave -noupdate /tb/AddressB
add wave -noupdate /tb/ClockA
add wave -noupdate /tb/ClockB
add wave -noupdate /tb/ClockEnA
add wave -noupdate /tb/ClockEnB
add wave -noupdate /tb/WrA
add wave -noupdate /tb/WrB
add wave -noupdate /tb/ResetA
add wave -noupdate /tb/ResetB
add wave -noupdate -radix hexadecimal /tb/QA
add wave -noupdate /tb/QB
add wave -noupdate /tb/i0
add wave -noupdate /tb/i1
add wave -noupdate /tb/i2
add wave -noupdate /tb/i3
add wave -noupdate /tb/i4
add wave -noupdate /tb/i5
add wave -noupdate /tb/i6
add wave -noupdate /tb/i7
add wave -noupdate /tb/i8
add wave -noupdate /tb/i9
add wave -noupdate /tb/i10
add wave -noupdate /tb/i11
add wave -noupdate /tb/i12
add wave -noupdate /tb/i13
add wave -noupdate /tb/i14
add wave -noupdate /tb/i15
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {186061 ps} 0} {{Cursor 2} {99711 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {94703 ps} {242731 ps}
