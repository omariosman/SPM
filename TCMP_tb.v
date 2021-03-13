// file: CSA_tb.v
// author: @omar_elsayed
// Testbench for CSA

`timescale 1ns/1ns

module TCMP_tb;
	//Inputs
	reg clk;
	reg rst;
	reg A;

	

	//Outputs
	wire S;
	


	//Instantiation of Unit Under Test
	TCMP uut (
		.clk(clk),
		.rst(rst),
		.A(A),
		.S(S)
	);


	initial begin

    $dumpfile("TCMP_tb.vcd");
    $dumpvars(0, TCMP_tb);
	//Inputs initialization
        rst = 0;
        rst = 1;

        #20;
        rst = 0;
	    A = 0;
		

        #20;
        A = 0;

        #20;
        A = 1;

        #20;
        A = 0;


        #20;
        A = 1;



        #20;
        A = 0;


    #1000 $finish;
    end

    initial begin
	//Wait for the reset
        clk = 0;
        forever #10 clk = ~clk;
	end

endmodule