module demux_1x2_tb;

    // 1. Local Test Inputs (reg)
    reg t_Y;
    reg t_S;
    
    // 2. Separate 2-bit Output Wires for each modeling style
    wire [1:0] I_beh; // Catching the full bus at once
    wire [1:0] I_df;  
    wire [1:0] I_str; 

    // 3. Connect the Behavioral Module
    demux_1x2_beh uut_beh (
        .Y(t_Y),
        .S(t_S),
        .I(I_beh) // Connect the whole bus smoothly
    );

    // 4. Connect the Dataflow Module
    demux_1x2_dataflow uut_df (
        .Y(t_Y),
        .S(t_S),
        .I(I_df)
    );

    // 5. Connect the Structural Module
    demux_1x2_structural uut_str (
        .Y(t_Y),
        .S(t_S),
        .I(I_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Apply Test Vectors (Your routine remains identical)
    initial begin
        // --- PHASE 1: S = 0 (Data Y must route to I[0]) ---
        t_S = 1'b0;
        
        t_Y = 1'b0; #10; 
        t_Y = 1'b1; #10; 
        t_Y = 1'b0; #10; 

        // --- PHASE 2: S = 1 (Data Y must route to I[1]) ---
        t_S = 1'b1;
        
        t_Y = 1'b0; #10; 
        t_Y = 1'b1; #10; 
        t_Y = 1'b0; #10; 
        
        $finish; 
    end

endmodule