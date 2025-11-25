onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /address_decoder_tb/rst
add wave -noupdate /address_decoder_tb/clk
add wave -noupdate /address_decoder_tb/SCL
add wave -noupdate /address_decoder_tb/SCL_prev
add wave -noupdate /address_decoder_tb/SDA
add wave -noupdate /address_decoder_tb/enable
add wave -noupdate /address_decoder_tb/UUT/controller/current_state_r
add wave -noupdate /address_decoder_tb/UUT/controller/next_state_r
add wave -noupdate /address_decoder_tb/UUT/controller/bit_count
add wave -noupdate /address_decoder_tb/done
add wave -noupdate /address_decoder_tb/selected
add wave -noupdate /address_decoder_tb/UUT/controller/bit_count_enable
add wave -noupdate /address_decoder_tb/UUT/controller/bit_count_rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {212775 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {206208 ps} {237568 ps}
