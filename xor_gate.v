module xor_behavioral(
  input wire a,
  input wire b,
  output reg y
);
  
  always@(*) begin
    if( a != b ) begin
      y = 1'b1;
    end else begin 
      y = 1'b0;
    end
  end  
endmodule	
    
module xor_structural(
    input wire a,
    input wire b,
    output wire y
);
      
    wire w1 ,w2 ,w3;
    nand G1 (w1 , a , b);
    nand G2 (w2 , a , w1);
    nand G3 (w3 , w1 ,b );
    nand G4 (y , w2 , w3 );
      
endmodule