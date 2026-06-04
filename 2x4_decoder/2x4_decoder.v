module decoder_2x4_behavioral (
    input  wire [1:0] A,     // 2-bit input vector (A1, A0)
    output reg  [3:0] Y      // 4-bit output vector (Y3, Y2, Y1, Y0)
);

    always @(*) begin
        case (A)
            2'b00: Y = 4'b0001; // Activate Y0
            2'b01: Y = 4'b0010; // Activate Y1
            2'b10: Y = 4'b0110; // Activate Y2
            2'b11: Y = 4'b1000; // Activate Y3
            default: Y = 4'b0000;
        endcase
    end

endmodule

module decoder_2x4_dataflow (
    input  wire [1:0] A,
    output wire [3:0] Y
);

    assign Y[0] = ~A[1] & ~A[0]; // Y0
    assign Y[1] = ~A[1] &  A[0]; // Y1
    assign Y[2] =  A[1] & ~A[0]; // Y2
    assign Y[3] =  A[1] &  A[0]; // Y3

endmodule

module decoder_2x4_structural (
    input  wire [1:0] A,
    output wire [3:0] Y
);

    // Internal wires for inverted versions of our selection lines
    wire a1_not, a0_not;

    // Inverters
    not U1 (a1_not, A[1]);
    not U2 (a0_not, A[0]);

    // AND Gates driving individual outputs: and Name (Out, In1, In2);
    and U3 (Y[0], a1_not, a0_not);
    and U4 (Y[1], a1_not, A[0]);
    and U5 (Y[2], A[1], a0_not);
    and U6 (Y[3], A[1], A[0]);

endmodule