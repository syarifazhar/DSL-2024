`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 14:45:29
// Design Name: 
// Module Name: top_module
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

module top_module(
        input sysclk,
        input [1:0] btn,
        output pio37,
        output pio38,
        output pio39,
        output pio40,
        output pio41,
        output pio42,
        output pio43,
        output pio44,
        output pio45,
        output pio46,
        output pio47,
        output pio48,
        output [1:0] led,
        input vp_in,
        input vn_in,
        input [1:0] xa_n,
        input [1:0] xa_p,
        
        output uart_rxd_out,  // UART receiver output signal
        //led,           // 2-bit output controlling general-purpose LEDs
        output led0_b,        // Output controlling the blue component of LED0
        output led0_g,        // Output controlling the green component of LED0
        output led0_r,        // Output controlling the red component of LED0
        //sysclk,        // System clock input
        //btn,           // 2-bit input from button presses
        input uart_txd_in    // UART transmitter input signal
         
);

reg [15:0] cnter; //this is where to replace the RNG data value of 16 bits
wire rstn;
wire actv;
assign rstn = ~btn[1];
//assign actv = ~btn[0];
// Reset pin configuration using one of the button inputs, active low, unpress: reset is off
wire rstn2;
assign rstn2 = ~btn[0];
wire CLK500Hz,CLK50Hz,CLK1Hz;
wire [15:0] bcd_tim;

wire [15:0] seed;
reg [15:0] seed_r;
assign seed = seed_r;
wire [15:0] pee;
reg [15:0] pee_r;

reg [15:0] xnext;
reg [15:0] displayed_number_r;
wire [15:0] displayed_number;
assign displayed_number = displayed_number_r;
reg [15:0] disp_r;
wire [15:0] disp;
//assign disp = disp_r;
wire pioblbl;
reg [7:0] r = 8'd4;






// Configuration for unused LED pins, setting them to a high state
assign led0_b = 1'b1;
assign led0_g = 1'b1;
assign led0_r = 1'b1;

// LED configuration to display UART TX and RX activity
assign led[0] = uart_rxd_out;
assign led[1] = uart_txd_in;

// UART protocol instance for transmitting data with parameter configuration for parity
localparam UART_PARITY = 1'b0; // Parity configuration, 0 for even parity
reg uart_tx_ready;
wire uart_tx_vaild;
reg [7:0] uart_tx_data;
//x = seed * blabla / blabal 
//some transformation of seed. seed is reading


// Clock tree creation section with instances of a clock divider module to generate different clock domains
// UART clock
wire clk_uart, clk_tx_event, clk_data_proc;
clock_div clock_div_u0(
    .clkout(clk_uart),
    .rstn(rstn2),
    .clksrc(sysclk)
);

// Clock for TX event
clock_div clock_div_u1(
    .clkout(clk_tx_event),
    .rstn(rstn2),
    .clksrc(sysclk)
);

// Clock for data processing
clock_div clock_div_u3(
    .clkout(clk_data_proc),
    .rstn(rstn2),
    .clksrc(sysclk)
);

clock_div clock_div_u4(rstn,sysclk,CLK500Hz);
clock_div clock_div_u5(rstn,CLK500Hz,CLK1Hz);
defparam clock_div_u0.FREQ_INPUT = 12_000_000; // Input frequency to the clock divider
defparam clock_div_u0.FREQ_OUTPUT = 9_600;     // Output frequency for UART operations
defparam clock_div_u1.FREQ_INPUT = 12_000_000; // Input frequency
defparam clock_div_u1.FREQ_OUTPUT = 200;       // Output frequency for TX event timing
defparam clock_div_u3.FREQ_INPUT = 12_000_000; // Input frequency
defparam clock_div_u3.FREQ_OUTPUT = 100;       // Output frequency for data processing
defparam clock_div_u4.FREQ_INPUT  = 12_000_000;
defparam clock_div_u4.FREQ_OUTPUT = 500;
defparam clock_div_u5.FREQ_INPUT  = 500;
defparam clock_div_u5.FREQ_OUTPUT = 1;

localparam PIN15_ADDR = 8'h14;  //VAUX4;
localparam PIN16_ADDR = 8'h1C;  //VAUX12;

wire enable;                     //enable into the xadc to continuosly get data out
reg [6:0] Address_in = 7'h14;    //Adress of register in XADC drp corresponding to data
wire ready;                      //XADC port that declares when data is ready to be taken
wire [15:0] ADC_data;                //XADC data   



xadc_wiz_0 xadc_u0
(
    .daddr_in(PIN16_ADDR),        // Address bus for the dynamic reconfiguration port
    .dclk_in(sysclk),             // Clock input for the dynamic reconfiguration port
    .den_in(enable),              // Enable Signal for the dynamic reconfiguration port
    .di_in(0),                    // Input data bus for the dynamic reconfiguration port
    .dwe_in(0),                   // Write Enable for the dynamic reconfiguration port
    .vauxp12(xa_p[1]),
    .vauxn12(xa_n[1]),
    .vauxp4(xa_p[0]),
    .vauxn4(xa_n[0]),  
    .busy_out(),                 // ADC Busy signal
    .channel_out(),              // Channel Selection Outputs
    .do_out(ADC_data),           // Output data bus for dynamic reconfiguration port
    .drdy_out(ready),            // Data ready signal for the dynamic reconfiguration port
    .eoc_out(enable),            // End of Conversion Signal
    .vp_in(vp_in),               // Dedicated Analog Input Pair
    .vn_in(vn_in)
);

always @(posedge CLK1Hz) begin //no need to put it to register once from adc input, since seed is only going to be used once
//    disp <= ADC_data;
    if (ADC_data == 16'd0) begin
        seed_r <= 16'd1;
        end
    else begin
        seed_r <= ADC_data;
    end
end

//only register when button is pressed rstn
always@(negedge rstn or posedge CLK1Hz)begin
    if(!rstn)begin
        xnext <= seed;
        displayed_number_r <= 16'b0;
        end
    else begin
        xnext <= pee;
        displayed_number_r <= disp;
    end
end

chaotic_Lmap Lmap_u0(CLK1Hz, xnext, r, pee);

//always@(pee)begin 
  //  pee_r = pee;
//end

EWMA_avg avg_u0(CLK1Hz, seed, rstn, pee, disp);

drv_segment drv_segment_u0(displayed_number, rstn, CLK500Hz, disp, {pio43,pio46,pio47,pio37}, {pio40,pio38,pio45,pio42,pio41,pio39,pio48,pio44});

uart_tx uart_tx_u0(
    .clk(clk_uart),
    .ap_rstn(rstn2),
    .ap_ready(uart_tx_ready),
    .ap_vaild(uart_tx_vaild),
    .tx(uart_rxd_out),
    .pairty(UART_PARITY),
    .data(uart_tx_data)
);

// Implements a 16-bit auto-incrementing counter that transmits data to a PC.
// Since the UART protocol is limited to transmitting 8 bits per frame,
// a "odd" register is employed to divide the 16-bit counter into two sections,
// allowing for sequential transmission of each 8-bit segment.

reg odd;

always @(negedge rstn2 or posedge clk_data_proc) begin
    if (!rstn2) begin
        disp_r <= 8'h00;
        uart_tx_data <= 8'h00;
        odd <= 1'b0;
    end else begin
        disp_r <= disp;
        odd <= ~odd;
        uart_tx_data <= odd ? disp_r[15:8] : disp_r[7:0];
//        disp_r <= odd ? disp_r + 1'b1 : disp_r;
        //You can replace cnter with your random number generator;
        //e.g. a 16 bits wire [15:0] rng_number;
        // cnter <= odd ? rng_number : ; //Allow you to transmit number to PC;    
    end
end

// Control logic for UART transmission readiness based on TX event clock and reset signal
always @(posedge clk_tx_event or negedge rstn2) begin
    if (!rstn2) begin
        uart_tx_ready <= 1'b0;
    end else begin
        if (uart_tx_vaild) begin
            uart_tx_ready <= 1'b0;
        end else begin
            uart_tx_ready <= 1'b1;
        end
    end
end

//endmodule
//end of uart





// function to display number on 7segment
// function to displya on LAPTOP SCREEN using UART
//assign led[0] = CLK1Hz;
//assign led[1] = ~CLK1Hz;
endmodule
