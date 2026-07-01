`timescale 1ns / 1ps

module tb_johnson_counter;

    // Inputs to the Design Under Test (DUT) declared as registers
    reg clk;
    reg rst;

    // Outputs from the DUT declared as wires
    wire [3:0] q;

    // Instantiate the Johnson Counter module
    johnson_counter uut (
        .clk(clk),
      .rst(rst),
        .q(q)
    );

    // Clock Generation Logic (Period = 10ns)
    always begin
        #5 clk = ~clk;
    end

    // Stimulus Block
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;

        // Display format for simulation tracking
      $monitor("Time = %0t | Reset = %b | Q = %b", $time, rst, q);

        // Apply Reset to initialize register to 0000
        #10;
        rst = 1;
        #10;
        rst = 0; // Release reset to start counting

        // Let the counter run for 10 clock cycles to watch the 8-state sequence loop
        #100;

        // End simulation
        $finish;
    end

endmodule