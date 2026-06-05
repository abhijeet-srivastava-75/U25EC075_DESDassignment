module encoder_8x3_tb;

    // 1. Local Test Input (8-bit register)
    reg [7:0] t_D;
    
    // 2. Separate 3-bit Output Buses for each modeling style
    wire [2:0] y_beh; // Connects to Behavioral
    wire [2:0] y_df;  // Connects to Dataflow
    wire [2:0] y_str; // Connects to Structural

    // 3. Connect the Behavioral Module
    encoder_8x3_beh uut_beh (
        .D(t_D),
        .Y(y_beh)
    );

    // 4. Connect the Dataflow Module
    encoder_8x3_dataflow uut_df (
        .D(t_D),
        .Y(y_df)
    );

    // 5. Connect the Structural Module
    encoder_8x3_structural uut_str (
        .D(t_D),
        .Y(y_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Cycle through all 8 possible active-input combinations
    initial begin
        // Case 0: Channel 0 is Active -> Expect Y = 000
        t_D = 8'b0000_0001; #10;
        
        // Case 1: Channel 1 is Active -> Expect Y = 001
        t_D = 8'b0000_0010; #10;
        
        // Case 2: Channel 2 is Active -> Expect Y = 010
        t_D = 8'b0000_0100; #10;
        
        // Case 3: Channel 3 is Active -> Expect Y = 011
        t_D = 8'b0000_1000; #10;
        
        // Case 4: Channel 4 is Active -> Expect Y = 100
        t_D = 8'b0001_0000; #10;
        
        // Case 5: Channel 5 is Active -> Expect Y = 101
        t_D = 8'b0010_0000; #10;
        
        // Case 6: Channel 6 is Active -> Expect Y = 110
        t_D = 8'b0100_0000; #10;
        
        // Case 7: Channel 7 is Active -> Expect Y = 111
        t_D = 8'b1000_0000; #10;
        
        $finish; // End simulation
    end

endmodule