module ring_counter (
    input wire clk,      // Clock signal
    input wire reset,    // Active-high synchronous reset to initialize
    output reg [3:0] q   // 4-bit output state
);

    // Sequential logic triggered on the positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            // Initialize to the starting state where only the first bit is 1
            q <= 4'b1000;
        end else begin
            // Shift right and feed the last bit (q[0]) back into the first position (q[3])
            // This achieves the circular "ring" behavior
            q <= {q[0], q[3:1]};
        end
    end

endmodule