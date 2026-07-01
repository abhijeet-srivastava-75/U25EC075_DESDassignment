module jk_flip_flop (
  input wire J,
  input wire K,
  input clk,
  input rst,
  output reg Q
);
  always @( posedge clk or posedge rst ) begin 
    if( rst ) begin 
      Q <= 1'b0;
    end
      else begin 
        case({J,K}) 
          2'b00 : Q <= Q;
          2'b01 : Q <= 1'b0;
          2'b10 : Q <= 1'b1;
          2'b11 : Q <= ~Q;
        endcase
      end
  end
endmodule


module my_structural_counter (
  input wire clk , 
  input wire rst,
  output wire [ 1:0 ] Q // 2 bit counter
);
  
  wire J0 , J1 , K0 , K1 ; 
  assign J1 = Q[0];
  assign K1 = Q[0];
  assign J0 = 1'b1;
  assign K0 = 1'b1;
  
  //Instantiate the flip flop 
  jk_flip_flop FF0 ( J0 , K0 , clk , rst , Q[0] );
  jk_flip_flop FF1 ( J1 , K1 , clk , rst , Q[1] );
  
endmodule