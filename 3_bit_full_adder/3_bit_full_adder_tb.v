module adder_3bit_tb;

    // 1. Local Test Inputs (reg)
    reg [2:0] t_A;
    reg [2:0] t_B;
    reg       t_Cin;
    
    // 2. Local Test Outputs (wire) - Separate wires for each modeling style
    wire [2:0] sum_beh; wire cout_beh; // Behavioral
    wire [2:0] sum_df;  wire cout_df;  // Dataflow
    wire [2:0] sum_str; wire cout_str; // Structural

    // 3. Connect the Behavioral Module (uut1)
    adder_3bit_behavioral uut1 (
        .A(t_A), .B(t_B), .Cin(t_Cin),
        .Sum(sum_beh), .Cout(cout_beh)
    );

    // 4. Connect the Dataflow Module (uut2)
    adder_3bit_dataflow uut2 (
        .A(t_A), .B(t_B), .Cin(t_Cin),
        .Sum(sum_df), .Cout(cout_df)
    );

    // 5. Connect the Structural Module (uut3)
    adder_3bit_structural uut3 (
        .A(t_A), .B(t_B), .Cin(t_Cin),
        .Sum(sum_str), .Cout(cout_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Apply Test Vectors
    initial begin
        // Case 1: Simple addition without any carry (2 + 3 = 5)
        t_A = 3'd2; t_B = 3'd3; t_Cin = 1'b0; #10;
        
        // Case 2: Testing your "Cin" bit! (1 + 1 + 1 = 3)
        t_A = 3'd1; t_B = 3'd1; t_Cin = 1'b1; #10;
        
        // Case 3: Generating an overflow/carry-out (7 + 2 = 9 -> Sum=1, Cout=1)
        t_A = 3'd7; t_B = 3'd2; t_Cin = 1'b0; #10;
        
        // Case 4: Absolute maximum limit (7 + 7 + 1 = 15 -> Sum=7, Cout=1)
        t_A = 3'b111; t_B = 3'b111; t_Cin = 1'b1; #10;
        
        $finish; // Stop simulation
    end

endmodule      
      
      