Main points are understanding the parts of the code that contribute to the input/output of the board (ie clk, btnR) 
that allows the user to view and reset the timer. There was so many functions that we took abit of time understand what each function means 
eg if(!rstn)begin
        an_r <= 4'b0000; 
which resets the stopwatch to all 0s when button R is pressed. 
This was the line we modified the most with the one that is set to  
an_r <= 4'b1111; 
which resets all to zeros as button is pressed, which is more intuitive and closer to how a digital stopwatch resets. 
