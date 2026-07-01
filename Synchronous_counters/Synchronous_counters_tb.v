`timescale 1ns / 1ps

module tb_ripple_counter;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [3:0] count;

    // Instantiate the Unit Under Test (UUT)
    ripple_counter_4bit uut (
        .clk(clk), 
        .rst(rst), 
        .count(count)
    );

    // Clock generation (50MHz -> 20ns period)
    always begin
        #10 clk = ~clk;
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;

        // Hold reset state for 40 ns
        #40;
        rst = 0;
        
        // Let the counter run for 400 ns to see full rollover
        #400;
        
        // Apply reset again to test asynchronous reset behavior
        rst = 1;
        #20;
        rst = 0;
        
        #100;
        $finish; // End the simulation
    end
      
    // Optional: Monitor the changes in the console
    initial begin
        $monitor("Time = %0t | Reset = %b | Count = %b (%d)", $time, rst, count, count);
    end 
      
endmodule