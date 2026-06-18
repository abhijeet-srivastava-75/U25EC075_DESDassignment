`timescale 1ns / 1ps

module tb_booth_multiplier_8bit_comb;

    // Inputs
    reg signed [7:0] M;
    reg signed [7:0] Q;

    // Outputs
    wire signed [15:0] Y;

    // Instantiate UUT
    booth_multiplier_8bit_comb uut (
        .M(M), 
        .Q(Q), 
        .Y(Y)
    );

    initial begin
        $monitor("Time=%0dns | Inputs: M=%d, Q=%d | Output Product Y = %d (Binary: %b)", 
                 $time, M, Q, Y, Y);

        // Test Case 1: Match your image exactly (3 * 5 = 15)
        M = 8'd3;  Q = 8'd5;
        #10;
        
        // Test Case 2: Negative Multiplicand (-3 * 5 = -15)
        M = -8'd3; Q = 8'd5;
        #10;
        
        // Test Case 3: Negative Multiplier (12 * -4 = -48)
        M = 8'd12; Q = -8'd4;
        #10;

        // Test Case 4: Both Negative (-7 * -6 = 42)
        M = -8'd7; Q = -8'd6;
        #10;

        $finish;
    end
      
endmodule