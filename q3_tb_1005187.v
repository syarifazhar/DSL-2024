`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Syarifuddin Azhar bin Rosli 1005187
// Create Date: 05.03.2024 18:37:36
// Ended on: 07/03/2024 7:58PM
// 
//////////////////////////////////////////////////////////////////////////////////


module q3_tb_1005187;

    reg  [1:0]A;
    reg  [1:0]SEL;
    wire [1:0]W;
    wire [1:0]X;
    wire [1:0]Y;
    wire [1:0]Z;
    integer j;
    
     demultiplexer demux0 (   .A(A),
                              .SEL(SEL),
                              .W(W),
                              .X(X),
                              .Y(Y),
                              .Z(Z));
    
    initial begin
    
        $monitor("[%0t] SEL=0x%0h A=0x%0h W=0x%0h X=0x%0h Y=0x%0h Z=0x%0h", $time, SEL, A,W,X,Y,Z );
        
        SEL <= 2'b00;
        A <= 2'b00;
       
        
        for (j=1; j<4; j=j+1)begin
            #7  SEL <= j;
            #7  A <= j;
        end
            
        #7 $finish;
    end
endmodule
