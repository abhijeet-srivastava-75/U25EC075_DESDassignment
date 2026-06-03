module comparator_gate_level(
  input wire [1:0] A,
  input wire [1:0] B,
  output wire A_gt_B,
  output wire A_lt_B,
  output wire A_eq_B
);
  // internal wires 
  //for inverted inputs
  wire a1_not , a0_not , b1_not , b0_not;
  
  //for bit matching XNOR 
  wire eq1 , eq0;
  
  //for AND terms 
  wire gt_term1, gt_term2;
  wire lt_term1, lt_term2;
  
  not U1 ( a1_not , A[1]);
  not U2 ( a0_not , A[0]);
  not U3 (b1_not, B[1]);
  not U4 (b0_not, B[0]);
  
  xnor U5 ( eq1 , A[1] , B[1] );
  xnor U6 ( eq0 , A[0] , B[0] );
  
  //Greater than logic 
  and U7 ( gt_term1 , A[1] , b1_not);
  and U8 (gt_term2, eq1, A[0], b0_not);
  or U9 (A_gt_B, gt_term1, gt_term2);
   
  // less than logic 
  and U10 (lt_term1, a1_not, B[1]);
  and U11 (lt_term2, eq1, a0_not, B[0]);
  or  U12 (A_lt_B, lt_term1, lt_term2);
  

  // equality 
  and U13 (A_eq_B, eq1, eq0);
  
endmodule