`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.02.2024 17:01:45
// Design Name: 
// Module Name: Clock_tree
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


module clock_tree(
    input CLK12MHZ,         
    input rstn,             //NON_SYNC RESET (ACTIVE LOW)
    output reg CLK500Hz,    //OUTPUT - 500Hz CLOCK;
    output reg CLK1Hz       //OUTPUT - 1Hz   CLOCK;
);

reg [13:0] CLK_CNTER_500Hz;
reg [7:0] CLK_CNTER_1Hz;

//Generate 500Hz CLK; 
always@(posedge CLK12MHZ, negedge rstn) begin
    if(!rstn) begin
        CLK_CNTER_500Hz<=14'h0000;
        CLK500Hz <= 1'b0;
    end
    else begin
        if(CLK_CNTER_500Hz == 14'd12_000-1'b1) begin
            CLK500Hz <= ~ CLK500Hz;
            CLK_CNTER_500Hz <= 14'h0000;
        end
        else CLK_CNTER_500Hz <= CLK_CNTER_500Hz + 1'b1;
    end
end

//Generate 1Hz CLK;
always@(posedge CLK500Hz, negedge rstn)begin
    if(!rstn) begin
        CLK_CNTER_1Hz<=8'h00;
        CLK1Hz <= 1'b0;
    end
    else begin
        if(CLK_CNTER_1Hz == 8'd250-1'b1) begin
            CLK1Hz <= ~ CLK1Hz;
            CLK_CNTER_1Hz <= 8'h00;
        end
        else CLK_CNTER_1Hz <= CLK_CNTER_1Hz + 1'b1;
    end
end

endmodule