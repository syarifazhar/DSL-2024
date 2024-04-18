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



module clock_div_tb();
reg rstn;
wire clkout;
reg clk;

//reg clock;
always begin
	#1 clk <= ~clk;
end

clock_div clock_div_uTEST(
    .clkout(clkout),
    .rstn(rstn),
    .clksrc(clk)
);

defparam clock_div_uTEST.FREQ_INPUT = 500_000; // Input frequency to the clock divider
defparam clock_div_uTEST.FREQ_OUTPUT = 100_000;     // Output frequency for UART operations

initial begin
    clk = 1'b0;
    rstn = 1'b0;

    #5 rstn = 1'b1;

    #200 $finish;
end
endmodule


