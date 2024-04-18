`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 13:18:28
// Design Name: 
// Module Name: Lmap_tb
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


module Lmap_tb();
reg clock;
reg [15:0]xt;
reg [7:0] r;
wire [15:0]xtnext;

chaotic_Lmap lmap_u0(
    .clock(clock),
    .xt(xt),
    .r(r),
    .xtnext(xtnext)
);

always begin
    #5 clock <= ~clock;
    end
always @(posedge clock) begin
    #1 xt <= xtnext;
    end
initial begin
//    xtnext = 16'd0;
    clock = 0;
    xt = 16'd3000;
    r = 8'd4;
    #100;
    
    xt = 16'd12;
    #100
    $finish;
    
    end
endmodule
