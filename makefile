run:
	iverilog SPM.v SPM_tb.v -o SPM.vvp
do: run
	vvp SPM.vvp
all: do
	gtkwave SPM_tb.vcd

