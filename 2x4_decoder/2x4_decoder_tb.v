module decoder_2x4_tb;

    // 1. Local Test Input (Controlled by us)
    reg [1:0] t_A;
    
    // 2. Separate Output Buses for each modeling style
    wire [3:0] y_beh; // Connects to Behavioral
    wire [3:0] y_df;  // Connects to Dataflow
    wire [3:0] y_str; // Connects to Structural

    // 3. Connect the Behavioral Module
    decoder_2x4_behavioral uut_beh (
        .A(t_A),
        .Y(y_beh)
    );

    // 4. Connect the Dataflow Module
    decoder_2x4_dataflow uut_df (
        .A(t_A),
        .Y(y_df)
    );

    // 5. Connect the Structural Module
    decoder_2x4_structural uut_str (
        .A(t_A),
        .Y(y_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Cycle through all 4 possible input states
    initial begin
        // Display Terminal Header
        $display("Time\t Input(A)\t Y_Behavioral\t Y_Dataflow\t Y_Structural");
        $monitor("%0nt\t %b\t\t %b\t\t %b\t\t %b", $time, t_A, y_beh, y_df, y_str);

        // Case 1: Binary 00 (Decimal 0) -> Expect Bit 0 to go High (0001)
        t_A = 2'b00; #10;
        
        // Case 2: Binary 01 (Decimal 1) -> Expect Bit 1 to go High (0010)
        t_A = 2'b01; #10;
        
        // Case 3: Binary 10 (Decimal 2) -> Expect Bit 2 to go High (0100)
        t_A = 2'b10; #10;
        
        // Case 4: Binary 11 (Decimal 3) -> Expect Bit 3 to go High (1000)
        t_A = 2'b11; #10;
        
        $finish; // Terminate simulation
    end

endmodule