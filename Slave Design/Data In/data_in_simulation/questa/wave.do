onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /data_in_tb/NUM_BYTES
add wave -noupdate -radix unsigned /data_in_tb/clk
add wave -noupdate -radix unsigned /data_in_tb/SCL
add wave -noupdate -radix unsigned /data_in_tb/SCL_prev
add wave -noupdate -radix unsigned /data_in_tb/SDA
add wave -noupdate -radix unsigned /data_in_tb/SDA_prev
add wave -noupdate -radix unsigned /data_in_tb/enable
add wave -noupdate -radix unsigned /data_in_tb/rst
add wave -noupdate -radix unsigned /data_in_tb/done
add wave -noupdate -radix unsigned /data_in_tb/SDA_down
add wave -noupdate -radix unsigned -childformat {{{/data_in_tb/HEX_out[5]} -radix unsigned} {{/data_in_tb/HEX_out[4]} -radix unsigned} {{/data_in_tb/HEX_out[3]} -radix unsigned} {{/data_in_tb/HEX_out[2]} -radix unsigned} {{/data_in_tb/HEX_out[1]} -radix unsigned} {{/data_in_tb/HEX_out[0]} -radix unsigned}} -expand -subitemconfig {{/data_in_tb/HEX_out[5]} {-radix unsigned} {/data_in_tb/HEX_out[4]} {-radix unsigned} {/data_in_tb/HEX_out[3]} {-radix unsigned} {/data_in_tb/HEX_out[2]} {-radix unsigned} {/data_in_tb/HEX_out[1]} {-radix unsigned} {/data_in_tb/HEX_out[0]} {-radix unsigned}} /data_in_tb/HEX_out
add wave -noupdate -radix unsigned -childformat {{{/data_in_tb/data_to_send[6]} -radix unsigned} {{/data_in_tb/data_to_send[5]} -radix unsigned} {{/data_in_tb/data_to_send[4]} -radix unsigned} {{/data_in_tb/data_to_send[3]} -radix unsigned} {{/data_in_tb/data_to_send[2]} -radix unsigned} {{/data_in_tb/data_to_send[1]} -radix unsigned -childformat {{{/data_in_tb/data_to_send[1][7]} -radix unsigned} {{/data_in_tb/data_to_send[1][6]} -radix unsigned} {{/data_in_tb/data_to_send[1][5]} -radix unsigned} {{/data_in_tb/data_to_send[1][4]} -radix unsigned} {{/data_in_tb/data_to_send[1][3]} -radix unsigned} {{/data_in_tb/data_to_send[1][2]} -radix unsigned} {{/data_in_tb/data_to_send[1][1]} -radix unsigned} {{/data_in_tb/data_to_send[1][0]} -radix unsigned}}} {{/data_in_tb/data_to_send[0]} -radix unsigned -childformat {{{/data_in_tb/data_to_send[0][7]} -radix unsigned} {{/data_in_tb/data_to_send[0][6]} -radix unsigned} {{/data_in_tb/data_to_send[0][5]} -radix unsigned} {{/data_in_tb/data_to_send[0][4]} -radix unsigned} {{/data_in_tb/data_to_send[0][3]} -radix unsigned} {{/data_in_tb/data_to_send[0][2]} -radix unsigned} {{/data_in_tb/data_to_send[0][1]} -radix unsigned} {{/data_in_tb/data_to_send[0][0]} -radix unsigned}}}} -expand -subitemconfig {{/data_in_tb/data_to_send[6]} {-radix unsigned} {/data_in_tb/data_to_send[5]} {-radix unsigned} {/data_in_tb/data_to_send[4]} {-radix unsigned} {/data_in_tb/data_to_send[3]} {-radix unsigned} {/data_in_tb/data_to_send[2]} {-radix unsigned} {/data_in_tb/data_to_send[1]} {-radix unsigned -childformat {{{/data_in_tb/data_to_send[1][7]} -radix unsigned} {{/data_in_tb/data_to_send[1][6]} -radix unsigned} {{/data_in_tb/data_to_send[1][5]} -radix unsigned} {{/data_in_tb/data_to_send[1][4]} -radix unsigned} {{/data_in_tb/data_to_send[1][3]} -radix unsigned} {{/data_in_tb/data_to_send[1][2]} -radix unsigned} {{/data_in_tb/data_to_send[1][1]} -radix unsigned} {{/data_in_tb/data_to_send[1][0]} -radix unsigned}}} {/data_in_tb/data_to_send[1][7]} {-radix unsigned} {/data_in_tb/data_to_send[1][6]} {-radix unsigned} {/data_in_tb/data_to_send[1][5]} {-radix unsigned} {/data_in_tb/data_to_send[1][4]} {-radix unsigned} {/data_in_tb/data_to_send[1][3]} {-radix unsigned} {/data_in_tb/data_to_send[1][2]} {-radix unsigned} {/data_in_tb/data_to_send[1][1]} {-radix unsigned} {/data_in_tb/data_to_send[1][0]} {-radix unsigned} {/data_in_tb/data_to_send[0]} {-radix unsigned -childformat {{{/data_in_tb/data_to_send[0][7]} -radix unsigned} {{/data_in_tb/data_to_send[0][6]} -radix unsigned} {{/data_in_tb/data_to_send[0][5]} -radix unsigned} {{/data_in_tb/data_to_send[0][4]} -radix unsigned} {{/data_in_tb/data_to_send[0][3]} -radix unsigned} {{/data_in_tb/data_to_send[0][2]} -radix unsigned} {{/data_in_tb/data_to_send[0][1]} -radix unsigned} {{/data_in_tb/data_to_send[0][0]} -radix unsigned}} -expand} {/data_in_tb/data_to_send[0][7]} {-radix unsigned} {/data_in_tb/data_to_send[0][6]} {-radix unsigned} {/data_in_tb/data_to_send[0][5]} {-radix unsigned} {/data_in_tb/data_to_send[0][4]} {-radix unsigned} {/data_in_tb/data_to_send[0][3]} {-radix unsigned} {/data_in_tb/data_to_send[0][2]} {-radix unsigned} {/data_in_tb/data_to_send[0][1]} {-radix unsigned} {/data_in_tb/data_to_send[0][0]} {-radix unsigned}} /data_in_tb/data_to_send
add wave -noupdate -radix unsigned /data_in_tb/UUT/controller/current_state_r
add wave -noupdate -radix unsigned /data_in_tb/UUT/controller/next_state_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29329 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {65536 ps} {196608 ps}
