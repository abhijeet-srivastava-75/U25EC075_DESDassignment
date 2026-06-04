module adder_3bit_dataflow (
    input  wire [2:0] A,
    input  wire [2:0] B,
    input  wire       Cin,
    output wire [2:0] Sum,
    output wire       Cout
);

    assign {Cout, Sum} = A + B + Cin;

endmodule



module adder_3bit_behavioral (
    input  wire [2:0] A,
    input  wire [2:0] B,
    input  wire       Cin,
    output reg [2:0] Sum,
    output reg       Cout
);
  
  always@(*) begin 
    {Cout , Sum} = A + B + Cin;
  end 
endmodule



module full_adder_1bit (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
); 
  
  assign sum = a ^ b ^ cin;
  assign cout = (a&b) | (b&cin) | (a&cin);
  
endmodule
    
    module adder_3bit_structural(
      input  wire [2:0] A,
      input  wire [2:0] B,
      input  wire       Cin,
      output wire [2:0] Sum,
      output wire       Cout
);
      wire c1;
      wire c2;
    
      full_adder_1bit FA0(
        .a(A[0]),
        .b(B[0]),
        .cin(Cin),
        .sum(Sum[0]),
        .cout(c1)
      );
      
      full_adder_1bit FA1 (
        .a(A[1]),
        .b(B[1]),
        .cin(c1), 
        .sum(Sum[1]),
        .cout(c2)
      );
      
      full_adder_1bit FA2 (
        .a(A[2]),
        .b(B[2]),
        .cin(c2), 
        .sum(Sum[2]),
        .cout(Cout)
      );	
      
endmodule