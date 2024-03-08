`timescale 1ns / 1ps
//!DO NOT MODIFY MODULE NAME AND PORT NAME!
//Syarifuddin Azhar Bin Rosli
//1005187
//Created on: 07/03/2024 8:05 PM 
//Ended on: 
//Vivado is stress-free now, i think...


module nibbleadd(
    input [7:0]A,
    input [7:0]B,
    input ctrl,
    output reg [4:0]q
    
);
    
   

//YOUR CODE HERE
always@(*)
    begin
        if (ctrl == 0)
            begin
                 q = A[3:0] + B[3:0];
            end 
        else
            begin
                q = A[7:4] + B[7:4];
            end
    end
endmodule
