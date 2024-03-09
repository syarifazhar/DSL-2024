`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Syarifuddin Azhar Bin Rosli
// 1005187
// created on 09/03/2024 3:39PM
// ended on 09/03/2024 07:59PM
//////////////////////////////////////////////////////////////////////////////////


module CCTA_tb;
    reg [3:0]A = 4'b0000;
    reg [3:0]B = 4'b0000;
    reg [3:0]C = 4'b0000;
    reg ctrl = 0;
    reg rst;
    wire [4:0] q;
    reg [3:0]i;
 


    CCTA ccta0(.A(A), .B(B), .C(C), .rst(rst), .ctrl(ctrl), .q(q));
    
    initial begin
        $monitor("[%0t] A = %h B = %h C = %h rst = %d ctrl = %d q = %h",$time,A,B,C,rst,ctrl,q);
        begin
            rst <= 1; ctrl <= 0;
            #50 rst <= ~rst;
            for (i=0;i<10;i=i+1)
                begin
                    #10 A <= $random; B <= $random; C <= $random;
                end
            rst <= 0; 
            for (i=0;i<10;i=i+1)
                begin
                    #10 A <= $random; B <= $random; C <= $random;
                end 
           ctrl = 1;
           for (i=0;i<10;i=i+1)
                begin
                    #10 A <= $random; B <= $random; C <= $random;
                end 
            
         end   
        
            $finish;
        end    

endmodule
