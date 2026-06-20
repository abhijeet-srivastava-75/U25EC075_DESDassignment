module ripple_carry_adder_tb;

    parameter TEST_WIDTH = 8;
  	
  	reg  [TEST_WIDTH-1:0] t_A;
    reg  [TEST_WIDTH-1:0] t_B;
    reg                   t_Cin;
    wire [TEST_WIDTH-1:0] t_Sum;
    wire                  t_Cout;
  
  ripple_carry_adder #(.WIDTH(TEST_WIDTH)) uut (
        .A(t_A),
        .B(t_B),
        .Cin(t_Cin),
        .Sum(t_Sum),
        .Cout(t_Cout)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end
    
    initial begin
        $display("--- Starting Parameterized RCA Verification (8-Bit Mode) ---");
      
      t_A = 8'd5; t_B = 8'd12; t_Cin = 1'b0; #10;
        $display("A=%d, B=%d, Cin=%b | Sum=%d, Cout=%b", t_A, t_B, t_Cin, t_Sum, t_Cout);

        // Case 2: Adding with an initial Carry-In (100 + 50 + 1 = 151)
        t_A = 8'd100; t_B = 8'd50; t_Cin = 1'b1; #10;
        $display("A=%d, B=%d, Cin=%b | Sum=%d, Cout=%b", t_A, t_B, t_Cin, t_Sum, t_Cout);

        // Case 3: Generating an Overflow Carry-out (250 + 10 = 260)
        // Since max 8-bit value is 255, 260 rolls over to 4 with Cout = 1
        t_A = 8'd250; t_B = 8'd10; t_Cin = 1'b0; #10;
        $display("A=%d, B=%d, Cin=%b | Sum=%d, Cout=%b (Rollover Test)", t_A, t_B, t_Cin, t_Sum, t_Cout);

        $finish;
    end

endmodule