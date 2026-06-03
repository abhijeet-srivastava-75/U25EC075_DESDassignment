module comparator_tb;

    // 1. Local Test Inputs (Variables we control)
    reg [1:0] t_A;
    reg [1:0] t_B;
    
    // 2. Local Test Outputs (Wires we watch)
    wire tb_gt_gl;
    wire tb_lt_gl;
    wire tb_eq_gl;

    // 3. Connect your Gate-Level Module directly
    comparator_gate_level uut_gate (
        .A(t_A),
        .B(t_B),
        .A_gt_B(tb_gt_gl),
        .A_lt_B(tb_lt_gl),
        .A_eq_B(tb_eq_gl)
    );

    // 4. Turn on the waveform recorder
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 5. Apply the test combinations
    initial begin
        // Case 1: A = 00, B = 00 (Equal) -> Expect EQ = 1
        t_A = 2'b00; t_B = 2'b00; #10;
        
        // Case 2: A = 01, B = 10 (A < B)   -> Expect LT = 1
        t_A = 2'b01; t_B = 2'b10; #10;
        
        // Case 3: A = 11, B = 01 (A > B)   -> Expect GT = 1
        t_A = 2'b11; t_B = 2'b01; #10;
        
        // Case 4: A = 10, B = 10 (Equal) -> Expect EQ = 1
        t_A = 2'b10; t_B = 2'b10; #10;
        
        $finish; // End simulation
    end

endmodule