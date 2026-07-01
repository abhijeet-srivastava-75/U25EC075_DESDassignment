`timescale 1ns / 1ps

module tb_ring_counter;

    // Inputs to the Design Under Test (DUT) declared as registers
    reg clk;
    reg reset;

    // Outputs from the DUT declared as wires
    wire [3:0] q;

    // Instantiate the Ring Counter module
    ring_counter uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock Generation Logic (Period = 10ns, Frequency = 100MHz)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus Block
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;

        // Display format for simulation tracking
        $monitor("Time = %0t | Reset = %b | Q = %b", $time, reset, q);

        // Apply Reset to load the initial '1000' state
        #10;
        reset = 1;
        #10;
        reset = 0; // Release reset to start the counter

        // Let the counter run for 6 clock cycles to see it loop back
        #60;

        // End simulation
        $finish;
    end

endmodule