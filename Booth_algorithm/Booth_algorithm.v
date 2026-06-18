module booth_multiplier_8bit_comb (
    input  signed [7:0] M,   // Multiplicand
    input  signed [7:0] Q,   // Multiplier
    output reg signed [15:0] Y // Final 16-bit Product
);

    integer cycle;
    reg [7:0] A;
    reg [7:0] current_Q;
    reg q_minus_1;

    always @* begin
        // --- Initialization Stage ---
        A = 8'b0000_0000;
        current_Q = Q;
        q_minus_1 = 1'b0;

        // --- Execution Stage: Run for Q-bit times (8 Cycles) ---
        for (cycle = 0; cycle < 8; cycle = cycle + 1) begin
            
            // 1. Look at Q_0 and Q_-1 bits
            case ({current_Q[0], q_minus_1})
                2'b10: begin
                    A = A - M; // Rule: A = A - M
                end
                2'b01: begin
                    A = A + M; // Rule: A = A + M
                end
                default: begin
                    // 2'b00 or 2'b11 -> Do nothing, skip straight to shift
                    A = A; 
                end
            endcase

            // 2. Arithmetic Right Shift [A, Q, Q_-1]
            // We capture Q[0] before it shifts out to become the next q_minus_1
            q_minus_1 = current_Q[0]; 
            
            // Shift current_Q right, bringing in the lowest bit of A (A[0])
            current_Q = {A[0], current_Q[7:1]};
            
            // Shift A right, preserving the sign bit (MSB, A[7]) to maintain 2's complement
            A = {A[7], A[7:1]}; 
            
        end

        // --- End of Cycles: Assign final combined result ---
        Y = {A, current_Q};
    end

endmodule