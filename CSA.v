`timescale 1ns/1ns

`include "fulladder.v"
`include "dff.v"

module CSA(input clk, input rst, input x, input y, output sum);    
 
    wire fa_cout, fa_sum, dff_carry_out;
    //reg fa_sum;
    fulladder fa(x, y, dff_carry_out, fa_sum, fa_cout);
    
    dff dff_sum(fa_sum, rst, clk, sum);
    dff dff_carry(fa_cout, rst, clk, dff_carry_out);    

endmodule