module johnson_counter (
  input wire clk , rst ,
  output reg [3:0] q
);
  
  always @(posedge clk) begin
    if( rst == 1 ) begin
      q <= 4'b0000;
    end else begin 
      q <= {~q[0] , q[3:1]};
    end 
  end 
endmodule 
            