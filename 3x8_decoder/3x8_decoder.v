module decoder_3x8_behavioral (
    input  wire [2:0] A, // 3-bit input (A2, A1, A0)
    output reg  [7:0] Y  // 8-bit output (Y7 down to Y0)
);

    always @(*) begin
        case (A)
          
/* The underscore (_) in numbers like 8'b0000_0001 is completely         ignored by the compiler. It is there purely for human readability.
Think of it exactly like using commas in large decimal numbers:
In math, writing 1,000,000 is much easier for your eyes to read than 1000000.
In binary, scanning a massive wall of ones and zeros like 8'b00100000 makes it very easy to accidentally miscount the bits.*/
  
  
            3'b000: Y = 8'b0000_0001; // Y0 active
            3'b001: Y = 8'b0000_0010; // Y1 active
            3'b010: Y = 8'b0000_0100; // Y2 active
            3'b011: Y = 8'b0000_1000; // Y3 active
            3'b100: Y = 8'b0001_0000; // Y4 active
            3'b101: Y = 8'b0010_0000; // Y5 active
            3'b110: Y = 8'b0100_0000; // Y6 active
            3'b111: Y = 8'b1000_0000; // Y7 active
            default: Y = 8'b0000_0000;
        endcase
    end

endmodule


module decoder_3x8_dataflow (
    input  wire [2:0] A,
    output wire [7:0] Y
);

    // Shifts the number 1 to the left by the decimal value of A
    assign Y = 8'b0000_0001 << A;
   
  // crazy technique up there

endmodule

module decoder_3x8_structural (
    input  wire [2:0] A,
    output wire [7:0] Y
);

    // Inverted signals
    wire a2_not, a1_not, a0_not;

    not U1 (a2_not, A[2]);
    not U2 (a1_not, A[1]);
    not U3 (a0_not, A[0]);

    // 3-input AND gates: and Name (Out, In1, In2, In3);
    and G0 (Y[0], a2_not, a1_not, a0_not); // 000
    and G1 (Y[1], a2_not, a1_not, A[0]);   // 001
    and G2 (Y[2], a2_not, A[1],   a0_not); // 010
    and G3 (Y[3], a2_not, A[1],   A[0]);   // 011
    and G4 (Y[4], A[2],   a1_not, a0_not); // 100
    and G5 (Y[5], A[2],   a1_not, A[0]);   // 101
    and G6 (Y[6], A[2],   A[1],   a0_not); // 110
    and G7 (Y[7], A[2],   A[1],   A[0]);   // 111

endmodule