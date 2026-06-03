module xor_gates_tb;

    // 1. Inputs are 'reg' because we change them procedurally
    reg  t_a;
    reg  t_b;
    
    // 2. Outputs are 'wire' to observe what the chips spit out
    wire out_behavioral;
    wire out_structural;

    // 3. Connect the Behavioral Module
    xor_behavioral uut1 (
        .a(t_a),
        .b(t_b),
        .y(out_behavioral)
    );

    // 4. Connect the Structural Module
    xor_structural uut2 (
        .a(t_a),
        .b(t_b),
        .y(out_structural)
    );

    // 5. Enable the EPWave waveform camera recorder
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    // 6. Test all 4 possible combinations of a 2-input Truth Table
    initial begin
        // Case 1: 00 -> Expect both outputs to be 0
        t_a = 0; t_b = 0;
        #10;
        
        // Case 2: 01 -> Expect both outputs to be 1
        t_a = 0; t_b = 1;
        #10;
        
        // Case 3: 10 -> Expect both outputs to be 1
        t_a = 1; t_b = 0;
        #10;
        
        // Case 4: 11 -> Expect both outputs to be 0
        t_a = 1; t_b = 1;
        #10;
        
        $finish; // End simulation
    end

endmodule