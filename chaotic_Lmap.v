`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 11:44:08
// Design Name: 
// Module Name: chaotic_Lmap
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


module chaotic_Lmap(
input clock,
//input reset,
input [15:0]xt,
input [7:0] r,
output [15:0]xtnext
    );
    
reg [15:0] xtnext_r;
assign xtnext = xtnext_r;

wire [31:0] intermediate;
assign intermediate = r*xt*(65535-xt);
//reg next;
//assign ctnext = next;
always @(posedge clock ) begin
//    intermediate < = r*xt*(65535-xt);
    xtnext_r <= (intermediate + 32767) / 65535;
end

endmodule
