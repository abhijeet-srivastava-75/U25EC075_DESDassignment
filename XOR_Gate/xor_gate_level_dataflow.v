module xor_gate_level(
  input wire a,
  input wire b,
  output wire y
);
  wire a_not;
  wire b_not;
  wire w1;
  wire w2;
  
  not U1 (a_not , a);
  not U2 (b_not , b);
  
  and U3 (w1 , a , b_not );
  and U4 (w2 , b , a_not );
  
  or U5 (y , w1 , w2 );
  
endmodule

module xor_dataflow (
  input  wire a,
  input  wire b,
  output wire y 
);
  assign y = a ^ b;

endmodule