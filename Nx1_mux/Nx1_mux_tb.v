module mux_Nx1_tb;

    // 1. Define the test size parameter (3 select lines = 8x1 MUX)
    parameter TEST_SELECT_WIDTH = 3;
    parameter TEST_DATA_WIDTH   = (1 << TEST_SELECT_WIDTH); // 2^3 = 8

    // 2. Local Test Inputs (Dynamically sized)
    reg [TEST_DATA_WIDTH-1:0]   t_I;
    reg [TEST_SELECT_WIDTH-1:0] t_S;
    
    // 3. Separate Output Wires to capture each style's results
    wire y_beh; // Connects to Parameterized Behavioral
    wire y_df;  // Connects to Parameterized Dataflow
    wire y_str; // Connects to Parameterized Structural

    // 4. Connect the Parameterized Behavioral Module
    mux_Nx1_parameterized #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_beh (
        .I(t_I),
        .S(t_S),
        .Y(y_beh)
    );

    // 5. Connect the Parameterized Dataflow Module
    mux_Nx1_dataflow #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_df (
        .I(t_I),
        .S(t_S),
        .Y(y_df)
    );

    // 6. Connect the Parameterized Structural Module
    mux_Nx1_structural #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_str (
        .I(t_I),
        .S(t_S),
        .Y(y_str)
    );

    // 7. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 8. Apply Test Routine
    initial begin
        // Let's create a unique data background on the input bus:
        // Channels 2 and 5 are HIGH (1), all other channels are LOW (0)
        // Bus binary: 8'b0010_0100 (Bit 7 down to Bit 0)
        t_I = 8'b0010_0100; 
        
        $display("--- Starting Parameterized MUX Verification (8x1 Mode) ---");
        $display("Input Vector t_I = %b", t_I);
        
        // Test Channel 0 (Expect Y = 0)
        t_S = 3'd0; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 1 (Expect Y = 0)
        t_S = 3'd1; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 2 (Expect Y = 1, matches t_I[2])
        t_S = 3'd2; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 3 (Expect Y = 0)
        t_S = 3'd3; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 4 (Expect Y = 0)
        t_S = 3'd4; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 5 (Expect Y = 1, matches t_I[5])
        t_S = 3'd5; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 6 (Expect Y = 0)
        t_S = 3'd6; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);

        // Test Channel 7 (Expect Y = 0)
        t_S = 3'd7; #10;
        $display("Select = %d | Outputs: Beh=%b, DF=%b, Str=%b", t_S, y_beh, y_df, y_str);
        
        $display("--- Verification Complete ---");
        $finish; 
    end

endmodule