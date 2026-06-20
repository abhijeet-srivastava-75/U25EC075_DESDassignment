module full_adder (
  input wire a , input wire b, input wire cin ,
  output wire carry , output wire sum
);
  
  assign sum = a ^ b ^ cin ;
  assign carry = ( a & b ) | ( a & cin ) | ( b & cin );
  
endmodule 


module ripple_carry_adder #(
  parameter WIDTH = 4 
)(
  input wire [WIDTH - 1 : 0] A,
  input wire [WIDTH - 1 : 0] B,
  input wire Cin,
  output wire Cout,
  output wire [WIDTH - 1 : 0] Sum
);
  
  wire [WIDTH : 0] carry_wires;
  
  assign carry_wires[0] = Cin ;
  
  genvar i;
  generate 
    for( i = 0 ; i < WIDTH ; i = i + 1 ) begin : fa_loop
      full_adder fa_inst (
        .a(A[i]),
        .b(B[i]),
        .cin(carry_wires[i]),
        .carry(carry_wires[i+1]),
        .sum(Sum[i])
      );
    end 
  endgenerate
  
  assign Cout = carry_wires[WIDTH];
  
endmodule 