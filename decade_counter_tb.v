`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: EPD
// Name: Syarifuddin Azhar Bin Rosli
// 
// Create Date: 28.02.2024 11:26:07
// Design Name: decade counter tb
// 
//////////////////////////////////////////////////////////////////////////////////
module decade_counter_tb();

reg clk;
reg rst;
wire [3:0]count;
wire ten;

decade_counter decade_counter_u0(
    .clk(clk),
    .rst(rst),
    .count(count),
    .ten(ten)
);

always begin
    //YOUR CODE HERE - Generate 20 unit time clock;
     #25 clk=~clk; // simulated over 10us
end

initial begin
    //YOUR CODE HERE - Initialize the clk, rst;
    $display($time, " << Starting the Simulation >>");
    rst=0;
    clk=0;
 
   

end
endmodule
