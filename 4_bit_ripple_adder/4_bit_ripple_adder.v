 
// ==========================================
// 1. BEHAVIORAL MODELING (Your Code)
// ==========================================
module rca_4bit_behavioral (
  input wire [3:0] A,
  input wire [3:0] B,
  input wire       Cin,
  output reg [3:0] Sum,
  output reg       Cout
);
  
  always@(*) begin  
    {Cout, Sum} = A + B + Cin;
  end 
endmodule 


// ==========================================
// 2. DATAFLOW MODELING
// ==========================================
module rca_4bit_dataflow (
  input wire [3:0] A,
  input wire [3:0] B,
  input wire       Cin,
  output wire [3:0] Sum,
  output wire       Cout
);

  assign {Cout, Sum} = A + B + Cin;

endmodule


// ==========================================
// 3. STRUCTURAL MODELING
// ==========================================
// 1-bit Blueprint component
module full_adder_1bit (
  input  wire a,
  input  wire b,
  input  wire cin,
  output wire sum,
  output wire cout
); 
  assign sum  = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

// Main 4-bit Structural Chain Module
module rca_4bit_structural (
  input  wire [3:0] A,
  input  wire [3:0] B,
  input  wire       Cin,
  output wire [3:0] Sum,
  output wire       Cout
);

  wire c1, c2, c3; // Internal ripple carry lines

  full_adder_1bit FA0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(c1));
  full_adder_1bit FA1 (.a(A[1]), .b(B[1]), .cin(c1),  .sum(Sum[1]), .cout(c2));
  full_adder_1bit FA2 (.a(A[2]), .b(B[2]), .cin(c2),  .sum(Sum[2]), .cout(c3));
  full_adder_1bit FA3 (.a(A[3]), .b(B[3]), .cin(c3),  .sum(Sum[3]), .cout(Cout));

endmodule