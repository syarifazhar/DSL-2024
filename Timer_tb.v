`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.02.2024 17:06:01
// Design Name: 
// Module Name: Timer_tb
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


module timer_tb();

reg rstn;
reg actv;
reg CLK1Hz;
wire [15:0] bcd_tim;

timer timer_ux(rstn,actv,CLK1Hz,bcd_tim);

always begin
    #5 CLK1Hz = ~CLK1Hz;
end

initial begin
    rstn = 0;
    CLK1Hz = 1;
   
    $monitor("rstn;%b,Timer:%4x",rstn,bcd_tim);
    #10 rstn = 1;
    #10 actv = 1;
    #10 actv = 0;
    #(10 * 60 * 60 + 2) $stop;
    #10 $finish;
end

endmodule
