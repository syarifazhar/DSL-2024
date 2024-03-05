
//Syarifuddin Azhar Bin Rosli
//Vivado has my life...help
//Started on: 26/02/2024 7:09PM
//Finished on: 28/02/2024 9:47PM
//Modified on: 29/02/2024 12:29PM
//!DO NOT EDIT MODULE NAME AND PORT NAME!
module decade_counter(
    input clk,
    input rst,
    output reg[3:0] count = 0,
    output reg ten = 0 
);
//YOUR CODE HERE
always@(posedge clk or posedge rst)
    begin
        if (rst == 1'd1)
         begin
            count <=4'b0000;
            ten <= 1'd0;
         end
        else
         begin 
            if (count == 4'd9)
              begin
               count <= 4'b0000;
               ten <= ten + 1;
              end
           else
             begin
              //ten <= 0;
              count <= count + 4'b0001;
             end
        end
      end          
endmodule