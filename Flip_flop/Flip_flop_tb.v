module tb_jk_ff;
    reg J, K, clk, rst;
    wire Q;

    // Instantiate the Flip-Flop
    jk_flip_flop dut (J, K, clk, rst, Q);

    // Clock generator: Period = 10
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0; rst = 1; J = 0; K = 0;
        #10 rst = 0; // Release reset

        // Test Cases:
        // 1. Hold State (J=0, K=0)
        #10 J = 0; K = 0;
        
        // 2. Reset State (J=0, K=1)
        #10 J = 0; K = 1;
        
        // 3. Set State (J=1, K=0)
        #10 J = 1; K = 0;
        
        // 4. Toggle State (J=1, K=1)
        #10 J = 1; K = 1;
        #10 J = 1; K = 1; // Toggle again to see it flip back

        // 5. Asynchronous Reset Check
        #10 rst = 1;
        #10 rst = 0;

        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_jk_ff);
    end
endmodule