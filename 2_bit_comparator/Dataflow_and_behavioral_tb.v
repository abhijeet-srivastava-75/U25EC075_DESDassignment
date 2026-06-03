module comparator_tb;
    // This is just an empty container.
  reg [1:0] t_A;
    reg [1:0] t_B;
    
    wire tb_gt_beh, tb_lt_beh, tb_eq_beh; // Outputs from Behavioral chip
    wire tb_gt_df, tb_lt_df, tb_eq_df;   // Outputs from Dataflow chip
  
  // Connect the Behavioral Module
    comparator_behavioral uut1 (
        .A(t_A), .B(t_B), 
        .A_gt_B(tb_gt_beh), .A_lt_B(tb_lt_beh), .A_eq_B(tb_eq_beh)
    );

    // Connect the Dataflow Module
    comparator_dataflow uut2 (
        .A(t_A), .B(t_B), 
        .A_gt_B(tb_gt_df), .A_lt_B(tb_lt_df), .A_eq_B(tb_eq_df)
    );
  
// Turn on the waveform recorder
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // Apply test vectors
    initial begin
        // Case 1: Equal values (A = 0, B = 0) -> Expect EQ = 1
        t_A = 2'b00; t_B = 2'b00;
        #10; // Wait 10 ns
        
        // Case 2: A is less than B (A = 1, B = 2) -> Expect LT = 1
        t_A = 2'b01; t_B = 2'b10;
        #10;
        
        // Case 3: A is greater than B (A = 3, B = 1) -> Expect GT = 1
        t_A = 2'b11; t_B = 2'b01;
        #10;
        
        // Case 4: Equal values again (A = 2, B = 2) -> Expect EQ = 1
        t_A = 2'b10; t_B = 2'b10;
        #10;
        
        $finish; // Stop simulation
    end
endmodule
