`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.02.2024 17:00:24
// Design Name: 
// Module Name: Segment
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

module Segment(
    input CLK1Hz, // added the CLK1Hz so that the dp will blink according to that frequency
    input rstn,
    input clk500hz,
    input [15:0] bcd_num,
    output [3:0] an,
    output [7:0] segment
);
reg [7:0] segment_r;
reg [3:0] an_r;
assign segment = ~ segment_r;
reg [3:0] cur_num_r;        //Register - BCD Number Display at this moment; 
assign an = ~an_r;
reg COUNTT = 1'b0;
//Drive 7Segment Anode;
//When an_r == 0001, DIG4 will turn on;
//When an_r == 0001, at posedge clk500hz, an_r will be set to 0010(DIG3 ON);
//When an_r == 0010, at posedge clk500hz, an_r will be set to 0100(DIG2 ON);
//....
//DIG4 -> DIG3 -> DIG2 -> DIG1 -> DIG4 -> DIG3 -> DIG2 -> ...;
always @(negedge rstn,posedge clk500hz)begin
    if(!rstn)begin
        an_r <= 4'b0000;    //When system reset, empty all display;
    end
    else begin
        case(an_r)                  
        4'b0001: an_r <= 4'b0010;   //DISPLAY ON DIG3
        4'b0010: an_r <= 4'b0100;   //DISPLAY ON DIG2
        4'b0100: an_r <= 4'b1000;   //DISPLAY ON DIG1
        default: an_r <= 4'b0001;   //DISPLAY ON DIG4
        endcase
    end
end
// an always block to start count 0, 1, 0, 1, 0, 1.....
// so that when count is 0, the digit at anode 2 is displayed. at count 1, the dp is displayed.
// Hence, as the loop goes through the anodes, digit 2 and the dp take turns being shown at the high frequency
always @(an_r)begin
    if(an_r == 4'b0100)begin
        if(COUNTT == 1'b1) begin
            COUNTT <= 1'b0;
        end
        else begin
            COUNTT <= COUNTT + 1'b1;
        end
    end
end
//When DIG4 on, BCD Number Display at this moment is bcd_num[3:0];  (i.e Stop Watch - Second Unit)
//When DIG3 on, BCD Number Display at this moment is bcd_num[7:4];  (i.e Stop Watch - Second Decade)
//When DIG2 on, BCD Number Display at this moment is bcd_num[11:8]; (i.e Stop Watch - Minute Unit)
//When DIG1 on, BCD Number Display at this moment is bcd_num[15:12];(i.e Stop Watch - Minute Decade)
always @(an_r,bcd_num)begin
    case(an_r)
        4'b0001: cur_num_r <= bcd_num[3:0];
        4'b0010: cur_num_r <= bcd_num[7:4];
        4'b0100: begin //code to change the shown digit according to COUNTT
            if(COUNTT == 1'b1)begin
               cur_num_r <= 4'ha;
            end
            else begin
               cur_num_r <= bcd_num[11:8];
            end
        end
        4'b1000: cur_num_r <= bcd_num[15:12];
        default: cur_num_r <= 4'b0;
    endcase    
end

//Decode BCD NUM into corrosponding 7Segment Code;
//always @(cur_num_r) begin
//    case(cur_num_r)
//        4'h0:segment_r <= 8'h40;    //NUM "0"
//        4'h1:segment_r <= 8'h79;    //NUM "1"
//        4'h2:segment_r <= 8'h24;    //NUM "2"
//        4'h3:segment_r <= 8'h30;    //NUM "3"
//        4'h4:segment_r <= 8'h12;    //NUM "4"
//        4'h5:segment_r <= 8'h02;    //NUM "5"
//        4'h6:segment_r <= 8'h78;    //NUM "6"
//        4'h7:segment_r <= 8'h00;    //NUM "7"
//        4'h8:segment_r <= 8'h10;    //NUM "8"
//        4'h9:segment_r <= 8'h90;    //NUM "9"
//        default: segment_r <= 8'hff;
//    endcase
//end

always @(cur_num_r) begin
    case(cur_num_r)
        4'h0:segment_r <= 8'hc0;    //NUM "0"
        4'h1:segment_r <= 8'hf9;    //NUM "1"
        4'h2:segment_r <= 8'ha4;    //NUM "2"
        4'h3:segment_r <= 8'hb0;    //NUM "3"
        4'h4:segment_r <= 8'h99;    //NUM "4"
        4'h5:segment_r <= 8'h92;    //NUM "5"
        4'h6:segment_r <= 8'h82;    //NUM "6"
        4'h7:segment_r <= 8'hF8;    //NUM "7"
        4'h8:segment_r <= 8'h80;    //NUM "8"
        4'h9:segment_r <= 8'h90;    //NUM "9"
        4'ha: begin //This part of the code is to alternate the value of the DP, whether it is on or off, matching the 1 Hz frequency.
        if(CLK1Hz == 1'b1)begin
        segment_r <= 8'h7f;    //NUM "On"
        end
        else begin
        segment_r <= 8'hff;
        end
        end
        default: segment_r <= 8'hff;
    endcase
end

endmodule
