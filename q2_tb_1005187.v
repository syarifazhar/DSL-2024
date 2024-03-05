`timescale 1ns / 1ps
//why do this?
//cos it is important
//if not how to process bits easier
//fair enough \-_-/
//////////////////////////////////////////////////////////////////////////////////


module q2_tb_1005187;

    reg [1:0]A;
    reg [1:0]B;
    reg [1:0]C;
    reg [1:0]D;
    reg [1:0]SEL;
    wire [1:0]X;
    integer i;
    
    
    multiplexer mux0(   .A(A),
                        .B(B),
                        .C(C),
                        .D(D),
                        .SEL(SEL),
                        .X(X));
                        
    initial begin
    
        $monitor("[%0t] SEL=0x%0h A=0x%0h B=0x%0h C=0x%0h D=0x%0h X=0x%0h", $time, SEL, A, B, C, D, X);
        
        SEL <= 0;
        A <= $random;
        B <= $random;
        C <= $random;
        D <= $random;
        
        for (i=1; i<4; i=i+1)begin
            #5 SEL <= i;
       
        end
        
        #5 $finish;
    end 
    


endmodule
