module encoder_4x2_tb;

    // 1. Local Test Input (4-bit register)
    reg [3:0] t_D;
    
    // 2. Separate 2-bit Output Buses for each modeling style
    wire [1:0] y_beh; // Connects to Behavioral
    wire [1:0] y_df;  // Connects to Dataflow
    wire [1:0] y_str; // Connects to Structural

    // 3. Connect the Behavioral Module
    encoder_4x2_behavioral uut_beh (
        .D(t_D),
        .Y(y_beh)
    );

    // 4. Connect the Dataflow Module
    encoder_4x2_dataflow uut_df (
        .D(t_D),
        .Y(y_df)
    );

    // 5. Connect the Structural Module
    encoder_4x2_structural uut_str (
        .D(t_D),
        .Y(y_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Apply Test Vectors
    initial begin
        // Case 1: Channel 0 is Active -> Expect Y = 00
        t_D = 4'b0001; #10;
        
        // Case 2: Channel 1 is Active -> Expect Y = 01
        t_D = 4'b0010; #10;
        
        // Case 3: Channel 2 is Active -> Expect Y = 10
        t_D = 4'b0100; #10;
        
        // Case 4: Channel 3 is Active -> Expect Y = 11
        t_D = 4'b1000; #10;
        
        $finish; // End simulation
    end

endmodule


