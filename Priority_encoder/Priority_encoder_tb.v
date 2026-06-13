module priority_encoder_4x2_tb;

    // 1. Declare local registers for inputs and separate wires for each output style
    reg  [3:0] t_D;
    
    // Outputs for Behavioral Model
    wire [1:0] y_beh;
    wire       v_beh;
    
    // Outputs for Dataflow Model
    wire [1:0] y_df;
    wire       v_df;
    
    // Outputs for Structural Model
    wire [1:0] y_str;
    wire       v_str;

    // 2. Instantiate the Behavioral Module
    priority_encoder_4x2_beh uut_beh (
        .D(t_D), .Y(y_beh), .V(v_beh)
    );

    // 3. Instantiate the Dataflow Module
    priority_encoder_4x2_dataflow uut_df (
        .D(t_D), .Y(y_df), .V(v_df)
    );

    // 4. Instantiate the Structural Module
    priority_encoder_4x2_structural uut_str (
        .D(t_D), .Y(y_str), .V(v_str)
    );

    // 5. Setup VCD Waveform Dumping
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 6. Test Scenario Routine
    initial begin
        $display("--- Starting 4x2 Priority Encoder Verification ---");
        
        // Case 0: No inputs active. Expect V = 0, Y = 00
        t_D = 4'b0000; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 1: Only D[0] active. Expect V = 1, Y = 00
        t_D = 4'b0001; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 2: Only D[1] active. Expect V = 1, Y = 01
        t_D = 4'b0010; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 3: Overlap Test! Both D[1] and D[0] are active. D[1] should win. Expect V = 1, Y = 01
        t_D = 4'b0011; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 4: Only D[2] active. Expect V = 1, Y = 10
        t_D = 4'b0100; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 5: Messy Overlap! D[2], D[1], and D[0] are ALL active. D[2] should win. Expect V = 1, Y = 10
        t_D = 4'b0111; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 6: Absolute Priority! D[3] is active along with D[1]. D[3] must override everything. Expect V = 1, Y = 11
        t_D = 4'b1010; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);
        
        // Case 7: All inputs slammed HIGH at once. D[3] wins. Expect V = 1, Y = 11
        t_D = 4'b1111; #10;
        $display("In: %b | Beh: Y=%b V=%b | DF: Y=%b V=%b | Str: Y=%b V=%b", t_D, y_beh, v_beh, y_df, v_df, y_str, v_str);

        $display("--- Verification Complete ---");
        $finish;
    end

endmodule