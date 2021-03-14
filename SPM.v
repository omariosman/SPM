`timescale 1ns/1ns


`include "CSA.v"
`include "TCMP.v"
`include "shifter.v"

module SPM(input clk, input rst, input [31:0] MP, input [31:0] MC, input start, output [63:0] P, output reg done);
  
    reg [7:0] count;
    reg [31:0] serial_mp;
    wire unique_bit;
    wire [31:0] and_out, internal_sum;
    /*  
        Initilaze & Increment count
        Then set done signal when count == 64
    */
    always@(posedge start) begin
        serial_mp = MP;
    end

     always @( posedge start or posedge clk or posedge rst)begin
        if (rst)
        count<=0; 
        else 
        count<=count+1; 

        case (count)
        63: begin done=1; end
        default: done=0; 
        endcase


    end

    always@(posedge clk) begin
        if (rst == 0) begin
            serial_mp = serial_mp >> 1;
        end
    end
/*
    always@(posedge clk) begin
        //if start
        if (start) begin



            serial_mp = MP;
    
            if (rst) begin
                count = 0;
                
            end 
            else begin
                serial_mp <=  serial_mp >> 1;
                count <= count + 1;
                //$display("This is the count: %d", $signed(count));
                case (count)
                    63: done = 1;
                    default: done = 0;
                endcase
            end


        end
    end
*/

    
    genvar i;

    generate
    
    /* Creating the and gate and the tcmp */
    
    and and0(and_out[31], MC[31], serial_mp[0]);
    TCMP tcmp0(and_out[31], clk, rst, internal_sum[31]);


   
    
    /* Looping over all the Carry Save Adders in the middle */
    for(i = 30; i > 0; i=i-1) begin
        and and1(and_out[i], MC[i], serial_mp[0]);
        CSA csa1(clk, rst, and_out[i], internal_sum[i+1], internal_sum[i]);
    end

    /* Creating the and gate and the last CSA */
    and and2(and_out[0], MC[0], serial_mp[0]);
    CSA csa2(clk, rst, and_out[0], internal_sum[1], unique_bit);

    shifter shifter1(clk, rst, unique_bit, P);


    endgenerate


endmodule