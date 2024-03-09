`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Syarifuddin Azhar Bin Rosli
// 1005187
// this is the final torture...pls give me strength
// this is the final boss
// created on: 09/03/2024 3:30PM
// ended on 09/03/2024 07:59PM
//////////////////////////////////////////////////////////////////////////////////
//!DO NOT MODIFY MODULE NAME AND PORT NAME!
module CCTA(
        input [3:0] A,
        input [3:0] B,
        input [3:0] C,
        input rst,
        input ctrl,
        output reg [4:0] q
);


always@(*)
    begin
        if (rst == 1)
            begin
                q <= 0;
            end
            else
                if (ctrl == 0)
                    begin
                        q <= A + B;
                    end
                else 
                    begin
                        q <= A - C;
                    end
     end

endmodule