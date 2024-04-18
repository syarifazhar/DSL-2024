//`timescale 1ns / 1ps
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


//module ewma_tb();

//reg clock;
//reg [15:0] seed;
//reg reset;
//reg [15:0] xt;
//wire [15:0] avg;

//reg [7:0] r;
//wire [15:0]xtnext;

//chaotic_Lmap lmap_u0(
//    .clock(clock),
//    .xt(xt),
//    .r(r),
//    .xtnext(xtnext)
//);

//EWMA_avg ewma_u0(
//    .clock(clock),
//    .seed(seed),
//    .reset(reset),
//    .xt(xt),
//    .avg(avg)
//);

//always begin
//    #5 clock <= ~clock;
//    end
    
//always @(posedge clock) begin
//    #1 xt <= xtnext;
//    end

//initial begin
////    xtnext = 16'd0;
//    reset = 1'b1;
//    clock = 0;
//    seed = 16'd3000;
//    xt = seed;
//    r = 8'd4;
//    #5 reset = 1'b0;
//    #100;
//end
//endmodule
module ewma_tb();

reg clock;
reg [15:0] seed;
reg reset;
reg [15:0] xt;
wire [15:0] avg;
//assign rstn = ~reset;
reg [7:0] r;
wire [15:0]xtnext;

chaotic_Lmap lmap_u0(
    .clock(clock),
    .xt(xt),
    .r(r),
    .xtnext(xtnext)
);

EWMA_avg ewma_u0(
    .clock(clock),
    .seed(seed),
    .reset(reset),
    .xt(xt),
    .avg(avg)
);

always begin
    #5 clock <= ~clock; // Generate the clock signal
end

// Adjusted update mechanism for xt
always @(negedge reset or posedge clock) begin
    if (!reset) begin
        xt <= seed; // Initialize xt with seed on reset
    end else begin
        xt <= xtnext; // Update xt with xtnext only when not in reset
    end
end

initial begin
    clock = 0;
    reset = 1'b0; // Assert reset initially
    seed = 16'd3000; // Initialize seed value
    xt = seed; // Initialize xt to a known value
    r = 8'd4; // Set the 'r' parameter for chaotic_Lmap
    #10 reset = 1'b1; // Deassert reset after a short delay
    
    // The simulation now continues with reset deasserted,
    // allowing normal operation and updates based on xtnext.
    
    #200; // Run the simulation for a time
    seed = 16'd120;
    reset = 1'b0;
    #10 reset = 1'b1;
    #300;
    
    $finish; // End the simulation
end

endmodule
