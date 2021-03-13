`timescale 1ns/1ns



module fulladder (input X, input Y, input Ci, output S, output Co);  
  
   assign {Co, S} = X + Y + Ci;  
endmodule  
