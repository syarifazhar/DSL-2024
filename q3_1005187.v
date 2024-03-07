`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Syarifuddin Azhar bin Rosli
//1005187
//Vivado is enjoyable now?? idk man, pls help...
// Create Date: 05.03.2024 18:37:12
//Ended on: 07/03/2024 7:58PM
// Module Name: q3_1005187

//////////////////////////////////////////////////////////////////////////////////
//!DO NOT MODIFY MODULE NAME AND PORT NAME!
module demultiplexer(
    input [1:0]A,
    input [1:0]SEL,
    output reg [1:0]W,
    output reg [1:0]X,
    output reg [1:0]Y,
    output reg [1:0]Z
    );
    
//YOUR CODE HERE
always@(A or SEL)
    begin
        if (SEL == 2'b00)
            begin
                W <= A;
                X <= 2'b00;
                Y <= 2'b00;
                Z <= 2'b00;
            end
        if(SEL == 2'b01)
            begin
                W <= 2'b00;
                X <= A;
                Y <= 2'b00;
                Z <= 2'b00;
            end
        if(SEL == 2'b10)
            begin
                W <= 2'b00;
                X <= 2'b00;
                Y <= A;
                Z <= 2'b00;
            end
        if(SEL == 2'b11)
            begin
                W <= 2'b00;
                X <= 2'b00;
                Y <= 2'b00;
                Z <= A;
            end
    end

endmodule