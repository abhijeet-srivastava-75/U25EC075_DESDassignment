module encoder_8x3_beh (
    input  wire [7:0] D, // 8-bit input vector
    output reg  [2:0] Y  // 3-bit output vector
);

    always @(*) begin
        case (D)
            8'b0000_0001 : Y = 3'b000; // Channel 0
            8'b0000_0010 : Y = 3'b001; // Channel 1
            8'b0000_0100 : Y = 3'b010; // Channel 2
            8'b0000_1000 : Y = 3'b011; // Channel 3
            8'b0001_0000 : Y = 3'b100; // Channel 4
            8'b0010_0000 : Y = 3'b101; // Channel 5
            8'b0100_0000 : Y = 3'b110; // Channel 6
            8'b1000_0000 : Y = 3'b111; // Channel 7
            default      : Y = 3'b000;
        endcase
    end
endmodule

module encoder_8x3_dataflow (
    input  wire [7:0] D,
    output wire [2:0] Y
);

    assign Y[0] = D[1] | D[3] | D[5] | D[7];
    assign Y[1] = D[2] | D[3] | D[6] | D[7];
    assign Y[2] = D[4] | D[5] | D[6] | D[7];

endmodule

module encoder_8x3_structural (
    input  wire [7:0] D,
    output wire [2:0] Y
);

    // 4-input OR gate blueprint connections: or Name (Out, In1, In2, In3, In4);
    or G0 (Y[0], D[1], D[3], D[5], D[7]); // Bit 0
    or G1 (Y[1], D[2], D[3], D[6], D[7]); // Bit 1
    or G2 (Y[2], D[4], D[5], D[6], D[7]); // Bit 2

endmodule