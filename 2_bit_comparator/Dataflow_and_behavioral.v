module comparator_dataflow(
  input wire [1:0] A,
  input wire [1:0] B,
  output wire A_gt_B,
  output wire A_lt_B,
  output wire A_eq_B
);
  
  assign A_gt_B = (A > B);
  assign A_lt_B = (A < B);
  assign A_eq_B = (A == B);

endmodule

module comparator_behavioral(
  input wire [1:0] A,
  input wire [1:0] B,
  output reg A_gt_B,
  output reg A_lt_B,
  output reg A_eq_B
);
  always@(*) begin
    A_gt_B = 1'b0;
    A_lt_B = 1'b0;
    A_eq_B = 1'b0;
    
    if ( A > B ) begin 
      A_gt_B = 1'b1;
    end else if ( A < B ) begin 
      A_lt_B = 1'b1;
    end else begin
      A_eq_B = 1'b1;
    end
  end
endmodule 
    	
  