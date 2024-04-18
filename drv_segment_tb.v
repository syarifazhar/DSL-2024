//clock testbecnh

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04.04.2024 17:34:35
//// Design Name: 
//// Module Name: ewma_tb
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////



module drv_segment_tb();
reg [15:0] displayed_number;
reg rstn;
//reg clk500hz/\;
reg [15:0] bcd_num;
wire [3:0] an;
wire [7:0] segment;

//reg output_clock;
reg clk;
//reg int

always begin
	#1 clk <= ~clk;
end

always begin
    #10 bcd_num <= bcd_num + 1;
end
drv_segment drv_segment_uTEST(
    .displayed_number(displayed_number),
    .rstn(rstn),
    .clk500hz(clk),
    .bcd_num(bcd_num),
    .an(an),
    .segment(segment)
);

initial begin
    bcd_num = 16'd1234;
    displayed_number = 16'd1234;

    clk = 1'b0;
    rstn = 1'b0;

    #5 rstn = 1'b1;
    
    #200 $finish;
end
endmodule


