`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Edited by: Syarifuddin Azhar Bin Rosli
// Student ID: 1005187
//Started on: 29/02/2024 12:33PM
//Vivado is evil, Vivado is vile, like a disease~~~
//////////////////////////////////////////////////////////////////////////////////
module multiplexer(
    input [1:0]A,
    input [1:0]B,
    input [1:0]C,
    input [1:0]D,
    input [1:0]SEL,
    output reg [1:0]X
);

//YOUR CODE HERE
//TIPS: IN THE VERILOG CASE STATEMENT, YOU HAVE TO LIST ALL CONDITION TO AVIOD ANY AMBIGUOUS STATEMENT;

 always@(A or B or C or D or SEL)
    case(SEL)
        2'b00 : X <= A;
        2'b01 : X <= B;
        2'b10 : X <= C;
        2'b11 : X <= D;
    endcase
 
endmodule
