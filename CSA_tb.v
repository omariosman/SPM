// file: CSA_tb.v
// author: @omar_elsayed
// Testbench for CSA

`timescale 1ns/1ns

module CSA_tb;

	//Inputs
	reg clk;
	reg rst;
	reg x;
	reg y;
	

	//Outputs
	wire sum;
	


	//Instantiation of Unit Under Test
	CSA uut (
		.clk(clk),
		.rst(rst),
		.x(x),
		.y(y),
        .sum(sum)
	);


	initial begin

    $dumpfile("CSA_tb.vcd");
    $dumpvars(0, CSA_tb);
	//Inputs initialization
        rst = 0;
        rst = 1;

        #20;
        rst = 0;
	    x = 1;
		y= 0;

        #20;
        x = 1;
        y = 1;

        #20;
        x = 0;
        y = 0;

    #1000 $finish;
    end

    initial begin
	//Wait for the reset
        clk = 0;
        forever #10 clk = ~clk;
	end

endmodule