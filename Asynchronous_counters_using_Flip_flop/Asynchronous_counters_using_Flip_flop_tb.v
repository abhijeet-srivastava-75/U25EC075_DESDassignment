module tb_my_structural_counter;
    // 1. Declare inputs to the counter as 'reg' and outputs as 'wire'
    reg clk;
    reg rst;
    wire [1:0] Q;

    // 2. Instantiate the design under test (DUT) using the corrected logic
    // We override the internal assignments by matching ports explicitly
    my_structural_counter dut (
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    // 3. Clock Generator: Toggles every 5 time units (Total Period = 10)
    always #5 clk = ~clk;

    // 4. Stimulus Block
    initial begin
        // Initialize inputs at time t = 0
        clk = 0;
        rst = 1; // Start in reset state to clear the flip-flops

        // Hold reset for 15 time units to ensure a clean starting state
        #15; 
        rst = 0; // Release reset; the counter will now start counting

        // Let the counter run for 8 full clock cycles (80 time units)
        // This lets us watch it cycle through 00 -> 01 -> 10 -> 11 twice!
        #80;

        // Turn reset back on briefly to test if it forces the counter back to 00
        rst = 1;
        #10;
        rst = 0;
        
        #20; // Let it count a couple more steps
        
        $display("Simulation finished safely.");
        $finish; // End the simulation
    end

    // 5. Waveform Generation for EDA Playground (EPWave)
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_my_structural_counter);
    end
endmodule