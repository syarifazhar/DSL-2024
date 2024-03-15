`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.02.2024 17:06:45
// Design Name: 
// Module Name: Segment_tb
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

module segment_tb();
reg CLK1Hz;
reg rstn;
reg CLK500Hz;
reg [15:0] bcd_tim;
wire [3:0] AN;
wire [7:0] segment;

Segment segment_utb(
    .CLK1Hz(CLK1Hz),
    .rstn(rstn),
    .clk500hz(CLK500Hz),
    .bcd_num(bcd_tim),
    .an(AN),
    .segment(segment)
);

always begin
    #1 CLK500Hz <=~ CLK500Hz;
end
always begin
    #100 CLK1Hz <=~ CLK1Hz;
end

initial begin
    rstn = 0;
    CLK1Hz = 0;
    CLK500Hz = 0;
    bcd_tim <= 16'h0123;
    #10 rstn = 1;
    #1000;
    #10 $finish;
end

endmodule