`timescale 1ns/1ns


`include "CSA.v"
`include "TCMP.v"
`include "shifter.v"

module SPM(input clk, input rst, input [31:0] MP, input [31:0] MC, input start, output [63:0] P, output reg done);
    assign P = final_product;
    reg [7:0] count;
    always@(posedge start, posedge clk or posedge rst) begin
        if (rst) begin
            count = 0;
        end 
        else begin
            count <= count + 1;
            case (count) 
                64: done = 1;
                default: done = 0;
            endcase
        end
    end

    wire unique_bit;
    reg [31:0] serial_mp;
    wire [31:0] and_out, internal_sum;
    wire [63:0] final_product;
    always@(posedge start) begin
        serial_mp = MP;
    end

    generate
    
    /* Creating the and gate and the tcmp */
    
    and and0(and_out[31], MC[31], serial_mp[0]);
    TCMP tcmp0(and_out[31], clk, rst, internal_sum[31]);


    genvar i;
    
    /* Looping over all the Carry Save Adders in the middle */
    for(i = 30; i > 0; i=i-1) begin
        and and1(and_out[i], serial_mp[0], MC[i]);
        CSA csa1(clk, rst, and_out[i], internal_sum[i+1], internal_sum[i]);
    end

    /* Creating the and gate and the last CSA */
    and and2(and_out[0], MC[0], serial_mp[0]);
    CSA csa2(clk, rst, and_out[0], internal_sum[0], unique_bit);

    shifter shifter1(clk, rst, unique_bit, final_product);


    always @(posedge clk) begin
        if (rst == 0) begin
            serial_mp <=  serial_mp >> 1;
        end
    end

    endgenerate


endmodule