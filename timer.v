//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //6-bits to represent the highest number 59
);
  reg [5:0] current_state;
 
    // Next-state logic using nested ternary (mux) operators:
    //   load has priority over en
    //   en=1 decrements, but clamps at 0 (no wrap)
    wire [5:0] next_state = load ? load_value : en   ? ((current_state == 6'd0) ? 6'd0 : current_state - 6'd1) : current_state;
 
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
