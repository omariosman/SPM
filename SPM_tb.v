// file: SPM_tb.v
// author: @omar_elsayed
// Testbench for SPM

`timescale 1ns/1ns

module SPM_tb;

	//Inputs
	reg clk;
	reg rst;
	reg [31:0] MP;
	reg [31:0] MC;
	reg start;


	//Outputs
	wire [63:0] P;
	wire done;


	//Instantiation of Unit Under Test
	SPM uut (
		.clk(clk),
		.rst(rst),
		.MP(MP),
		.MC(MC),
		.start(start),
		.P(P),
		.done(done)
	);


	initial begin

    $dumpfile("SPM_tb.vcd");
    $dumpvars(0, SPM_tb);
	//Inputs initialization
		rst = 1;
		#10;
		MP = 2;
		MC = 3;
		start = 1;
		#10;
		rst = 0;
		start = 0;
		
		
		#10;
		
		
		
		#1320 $finish;




	end

	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
        
	

endmodule