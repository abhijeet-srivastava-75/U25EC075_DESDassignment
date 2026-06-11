module demux_1x4_tb;

    // 1. Local Test Inputs (reg)
    reg       t_Y;
    reg [1:0] t_S;
    
    // 2. Separate 4-bit Output Buses for each modeling style
    wire [3:0] I_beh; // Connects to Behavioral
    wire [3:0] I_df;  // Connects to Dataflow
    wire [3:0] I_str; // Connects to Structural

    // 3. Connect the Behavioral Module
    demux_1x4_beh uut_beh (
        .Y(t_Y),
        .S(t_S),
        .I(I_beh)
    );

    // 4. Connect the Dataflow Module
    demux_1x4_dataflow uut_df (
        .Y(t_Y),
        .S(t_S),
        .I(I_df)
    );

    // 5. Connect the Structural Module
    demux_1x4_structural uut_str (
        .Y(t_Y),
        .S(t_S),
        .I(I_str)
    );

    // 6. Waveform Recorder Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 7. Apply Test Vectors
    initial begin
        // --- PHASE 0: S = 00 (Data Y routes to I[0]) ---
        t_S = 2'b00;
        t_Y = 1'b0; #10;
        t_Y = 1'b1; #10; // I[0] should go high here

        // --- PHASE 1: S = 01 (Data Y routes to I[1]) ---
        t_S = 2'b01;
        t_Y = 1'b0; #10;
        t_Y = 1'b1; #10; // I[1] should go high here

        // --- PHASE 2: S = 10 (Data Y routes to I[2]) ---
        t_S = 2'b10;
        t_Y = 1'b0; #10;
        t_Y = 1'b1; #10; // I[2] should go high here

        // --- PHASE 3: S = 11 (Data Y routes to I[3]) ---
        t_S = 2'b11;
        t_Y = 1'b0; #10;
        t_Y = 1'b1; #10; // I[3] should go high here
        
        $finish; // End simulation
    end

endmodule