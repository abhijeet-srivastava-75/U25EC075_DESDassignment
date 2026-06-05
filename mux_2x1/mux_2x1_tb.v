module mux_2x1_tb;

    // Local Test Inputs
    reg [1:0] t_I;
    reg       t_S;
    
    // Separate Output Wires
    wire y_beh; 
    wire y_df;  
    wire y_str; 

    // Connect Behavioral
    mux_2x1_beh uut_beh (
        .I(t_I),
        .S(t_S),
        .Y(y_beh)
    );

    // Connect Dataflow
    mux_2x1_dataflow uut_df (
        .I(t_I),
        .S(t_S),
        .Y(y_df)
    );

    // Connect Structural
    mux_2x1_structural uut_str (
        .I(t_I),
        .S(t_S),
        .Y(y_str)
    );

    // Waveform Setup
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // Test Routines
    initial begin
        // S = 0 (Output follows I[0])
        t_S = 1'b0;
        t_I = 2'b10; #10; 
        t_I = 2'b01; #10; 
        t_I = 2'b00; #10; 
        t_I = 2'b11; #10; 

        // S = 1 (Output follows I[1])
        t_S = 1'b1;
        t_I = 2'b10; #10; 
        t_I = 2'b01; #10; 
        t_I = 2'b00; #10; 
        t_I = 2'b11; #10; 
        
        $finish; 
    end

endmodule