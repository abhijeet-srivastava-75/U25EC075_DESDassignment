module demux_1xN_tb;

    // 1. Define the test size parameter (3 select lines = 1x8 DEMUX)
    parameter TEST_SELECT_WIDTH = 3;
    parameter TEST_DATA_WIDTH   = (1 << TEST_SELECT_WIDTH); // 2^3 = 8

    // 2. Local Test Inputs
    reg                        t_Y;
    reg [TEST_SELECT_WIDTH-1:0] t_S;
    
    // 3. Separate 8-bit Output Buses to capture each style's results
    wire [TEST_DATA_WIDTH-1:0] I_beh; // Connects to Parameterized Behavioral
    wire [TEST_DATA_WIDTH-1:0] I_df;  // Connects to Parameterized Dataflow
    wire [TEST_DATA_WIDTH-1:0] I_str; // Connects to Parameterized Structural

    // 4. Connect the Parameterized Behavioral Module
    demux_1xN_parameterized #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_beh (
        .Y(t_Y),
        .S(t_S),
        .I(I_beh)
    );

    // 5. Connect the Parameterized Dataflow Module
    demux_1xN_dataflow #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_df (
        .Y(t_Y),
        .S(t_S),
        .I(I_df)
    );

    // 6. Connect the Parameterized Structural Module
    demux_1xN_structural #(.SELECT_WIDTH(TEST_SELECT_WIDTH)) uut_str (
        .Y(t_Y),
        .S(t_S),
        .I(I_str)
    );

    // 7. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 8. Apply Test Routine
    initial begin
        $display("--- Starting Parameterized DEMUX Verification (1x8 Mode) ---");
        
        // --- Loop through each channel from 0 to 7 ---
        for (integer i = 0; i < TEST_DATA_WIDTH; i = i + 1) begin
            t_S = i; // Assign channel select index
            
            // Send a low data pulse
            t_Y = 1'b0; #10;
            
            // Send a high data pulse -> Look for this pulse on bit I[i]
            t_Y = 1'b1; #10;
            
            $display("Select = %d | Active Channel Outputs: Beh=%b, DF=%b, Str=%b", 
                     t_S, I_beh[i], I_df[i], I_str[i]);
        end
        
        $display("--- Verification Complete ---");
        $finish; 
    end

endmodule