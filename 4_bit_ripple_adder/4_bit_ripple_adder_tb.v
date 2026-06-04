module rca_4bit_tb;
  
  //inputs 
  reg [3:0] t_A;
  reg [3:0] t_B;
  reg t_Cin;
  
  //outputs
  wire [3:0] sum_beh; wire cout_beh;
  wire [3:0] sum_df;  wire cout_df;
  wire [3:0] sum_str; wire cout_str;
  
  rca_4bit_behavioral uut1(
    .A(t_A),
    .B(t_B),
    .Cin(t_Cin),
    .Sum(sum_beh),
    .Cout(cout_beh)
  );
  
  rca_4bit_dataflow uut2 (
        .A(t_A), .B(t_B), .Cin(t_Cin), .Sum(sum_df), .Cout(cout_df)
    );

    rca_4bit_structural uut3 (
        .A(t_A), .B(t_B), .Cin(t_Cin), .Sum(sum_str), .Cout(cout_str)
    );
  
  initial begin
    $dumpfile("dump.vcd");
        $dumpvars(1);
    end
  
  initial begin
    // Case 1: 5 + 4 = 9 (Sum = 9, Cout = 0)
    t_A = 4'd5; t_B = 4'd4; t_Cin = 1'b0; #10;
        
    // Case 2: 12 + 3 + 1 (Cin) = 16 -> Overflows! (Sum = 0, Cout = 1)
     t_A = 4'd12; t_B = 4'd3; t_Cin = 1'b1; #10;
        
     // Case 3: Max values 15 + 15 = 30 (Sum = 14, Cout = 1)
     t_A = 4'b1111; t_B = 4'b1111; t_Cin = 1'b0; #10;

     $finish;
    end

endmodule
  
  
 