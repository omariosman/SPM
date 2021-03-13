`timescale 1ns/1ns


module shifter(input clk, input rst, input bit, output reg [63:0] out);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out = 0;
        end

        

        out = {bit, out[62:0]};

    end
endmodule