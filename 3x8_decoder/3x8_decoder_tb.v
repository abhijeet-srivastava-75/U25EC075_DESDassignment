module decoder_3x8_tb;

    // 1. Local Test Input (3-bit register)
    reg [2:0] t_A;
    
    // 2. Separate 8-bit Output Buses for each modeling style
    wire [7:0] y_beh; // Connects to Behavioral
    wire [7:0] y_df;  // Connects to Dataflow
    wire [7:0] y_str; // Connects to Structural

    // 3. Connect the Behavioral Module (Case statement)
    decoder_3x8_behavioral uut_beh (
        .A(t_A),
        .Y(y_beh)
    );

    // 4. Connect the Dataflow Module (Left-Shift Operator)
    decoder_3x8_dataflow uut_df (
        .A(t_A),
        .Y(y_df)
    );

    // 5. Connect the Structural Module (Pure 3-input AND gates)
    decoder_3x8_structural uut_str (
        .A(t_A),
        .Y(y_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Cycle through all 8 possible input combinations
    initial begin
        // Case 0: Input = 000 (Decimal 0) -> Expect Y0 to go high (0000_0001)
        t_A = 3'b000; #10;
        
        // Case 1: Input = 001 (Decimal 1) -> Expect Y1 to go high (0000_0010)
        t_A = 3'b001; #10;
        
        // Case 2: Input = 010 (Decimal 2) -> Expect Y2 to go high (0000_0100)
        t_A = 3'b010; #10;
        
        // Case 3: Input = 011 (Decimal 3) -> Expect Y3 to go high (0000_1000)
        t_A = 3'b011; #10;
        
        // Case 4: Input = 100 (Decimal 4) -> Expect Y4 to go high (0001_0000)
        t_A = 3'b100; #10;
        
        // Case 5: Input = 101 (Decimal 5) -> Expect Y5 to go high (0010_0000)
        t_A = 3'b101; #10;
        
        // Case 6: Input = 110 (Decimal 6) -> Expect Y6 to go high (0100_0000)
        t_A = 3'b110; #10;
        
        // Case 7: Input = 111 (Decimal 7) -> Expect Y7 to go high (1000_0000)
        t_A = 3'b111; #10;
        
        $finish; // End simulation run
    end

endmodule

