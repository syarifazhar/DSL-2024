`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 20:56:49
// Design Name: 
// Module Name: q4_tb_1005187
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module nibbleadd_tb;

        reg [7:0]A = 8'h00;
        reg [7:0]B = 8'h00;
        reg ctrl = 0;
        wire [4:0]q;
        reg [2:0] i = 0;
        
        
        nibbleadd nib0( .A(A),
                        .B(B),
                        .ctrl(ctrl),
                        .q(q));
        
        initial begin
            $monitor("[%0t] ctrl = %d A = %h B = %h q = %h",$time,ctrl,A,B,q);begin
            //#500 ctrl <= ~ctrl;
            for(i=0;i<6;i=i+1)
                begin
                     #8 A <= $random; B <= $random; 
                end
            #10 ctrl <= ~ctrl;
            for(i=0;i<6;i=i+1)
                begin       
                   #8 A <= $random; B <= $random; 
                end 
           end
         #20 $finish;
        end

endmodule
