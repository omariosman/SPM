`timescale 1ns/1ns

//`include "dff.v"
module TCMP(input A, input clk, input rst, output S);
    
    wire ff2_out, or_out, xor_out;

    xor xor1(xor_out, A, ff2_out);

    or or1(or_out, A, ff2_out);

    
    dff dff1(xor_out, rst, clk, S);
    dff dff2(or_out, rst, clk, ff2_out);

endmodule