module demux_1x2_beh (
  input wire Y , input wire S , output reg [1:0] I
);
  
  always@(*) begin 
    if ( S == 0 ) begin 
      I[0] = Y;
      I[1] = 1'b0;
    end else if ( S ==1 ) begin 
      I[1] = Y;
      I[0] = 1'b0;
    end 
  end 
 endmodule
    
module demux_1x2_dataflow (
  input wire Y , input wire S , output wire [1:0] I
); 
  assign I[0] = Y & ~S;
  assign I[1] = Y & S;
endmodule 


module demux_1x2_structural ( 
  input wire Y , input wire S , output wire [1:0] I
); 
  wire s_not ;
  
  not G1 ( s_not , S );
  
  and G2 ( I[0] , Y , s_not );
  and G3 ( I[1] , Y , S );
endmodule
  