module tb_up_down_counter;
    reg clk;
    reg reset;
    reg up_down;
    wire [2:0] count;

    // Instantiate the design under test (DUT)
    up_down_counter dut (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .count(count)
    );

    // Generate a clock signal that toggles every 5 time units (Period = 10)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        up_down = 1;

        #12; // Wait a bit
        reset = 0; // Release reset, should start counting UP (0 -> 1 -> 2...)
        
        #50; // Let it count up for 5 clock cycles
        up_down = 0; // Switch to counting DOWN
        
        #50; // Let it count down
        $finish; // End simulation
    end

    // Code required by EDA Playground to generate waveforms
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_up_down_counter);
    end
endmodule