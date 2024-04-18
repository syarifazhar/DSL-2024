`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 11:56:05
// Design Name: 
// Module Name: EWMA_avg
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


module EWMA_avg(
//input wire [15:0] current_avg,
input clock,
input [15:0] seed,
input reset,
input [15:0] xt,
output[15:0] avg
    );
wire [31:0] inter;
assign inter = (avg*40 + 10*xt)/50;
reg [31:0] seedinter;
reg [15:0] rr;

reg [15:0] avg_r;
assign avg = avg_r;

always @(posedge xt or negedge reset) begin
    if (!reset) begin
//        seedinter = rr*seed*(65535-seed) ;
//        avg = seedinter[15:0];
        avg_r = seed;
    end
//    if xt == sometransformation of seed begin
//    avg <= xt;    
//end
    else begin
//        #1;
        avg_r <= inter[15:0];
    end
end
endmodule
