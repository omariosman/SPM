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

wire [63:0] golden_product;
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

	event reset_trigger;
	event reset_done_trigger;

	initial begin
	


    $dumpfile("SPM_tb.vcd");
    $dumpvars(0, SPM_tb);
	#100000 $finish;
	end
	
	/* RESET LOGIC */
	
	initial 

		begin: TEST_CASE
			start = 0;
			//rst = 1;
			#10 -> reset_trigger;
			//@(reset_done_trigger);
			MC = $urandom_range(-50,50);
			MP = $urandom_range(-50,50);
	
			//@(negedge clk);
			start = 1;
			@(negedge clk);
			start = 0;
			rst = 0;
			
		end

	initial begin
		forever begin
			@(reset_trigger);
			@(negedge clk);
			rst = 0;
			@(negedge clk);
			rst = 1;
			@(negedge clk);
			rst = 0;
			-> reset_done_trigger;		
		end
	end	


//cont. assignemnent
	//Golden Model

	always @(negedge done) begin
		#10;
		MC = $urandom_range(-50,50);
		MP = $urandom_range(-50,50);	
	end
	assign golden_product = MC * MP;
	

	//The Checker
	always@(posedge done) begin
		@(negedge clk);
		if (P != golden_product) begin
			$display("Error at time %d", $time);
			$display("Expected values as %d but got %d", golden_product, P);
		end
		#100 $finish;
	end
	

	//Inputs initialization
/*
initial begin
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
*/

		initial begin
		clk = 0;
		forever #10 clk = ~clk;
		end


  


endmodule


