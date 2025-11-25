vlog -f files.f

vsim -c data_in_tb -voptargs="+acc" \
    -do "log -r /*; run -all; quit -f"

wlf2vcd vsim.wlf -o waves.vcd
gtkwave waves.vcd &
