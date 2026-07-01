module t_ff (
  input wire clk , rst ,
  output reg q , q_bar
);
  
  assign q_bar = ~q ;
  
  always @(negedge clk or posedge rst) begin 
    if (rst) begin
            q <= 1'b0;
        end else begin
            q <= ~q; // Toggle behavior
        end
  end 
endmodule 

module ripple_counter_4bit ( 
  input wire clk , rst , 
  output wire [3 : 0] count 
);
  wire [3:0] q_bar;
  
  t_ff ff0(.clk(clk) , .rst(rst) , .q(count[0]) , .q_bar(q_bar[0]));
  
  t_ff ff1 (.clk(count[0]), .rst(rst), .q(count[1]), .q_bar(q_bar[1]));
  t_ff ff2 (.clk(count[1]), .rst(rst), .q(count[2]), .q_bar(q_bar[2]));
  t_ff ff3 (.clk(count[2]), .rst(rst), .q(count[3]), .q_bar(q_bar[3]));

endmodule
  