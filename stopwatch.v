//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);
    reg [5:0] current_state;
 
    // Next-state logic:
    // When en=1, advance (with wrap at 59); when en=0, hold
    wire [5:0] next_state = en ? ((current_state == 6'd59) ? 6'd0 : current_state + 6'd1)
                               : current_state;
 
    // D flip-flop register with asynchronous reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= 6'd0;
        else
            current_state <= next_state;
    end
 
    assign state = current_state;
 
endmodule
 
   
endmodule




