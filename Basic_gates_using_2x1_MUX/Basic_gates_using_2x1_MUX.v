// The basic building block blueprint
module structural_2x1_block (
    input  wire [1:0] data_in,
    input  wire       sel,
    output wire       data_out
);
    wire s_not, w0, w1;
    not (s_not, sel);
    and (w0, data_in[0], s_not);
    and (w1, data_in[1], sel);
    or  (data_out, w0, w1);
endmodule


// Master module implementing gates via MUX instantiations
module gates_using_mux (
    input  wire A,
    input  wire B,
    output wire Y_not,
    output wire Y_and,
    output wire Y_or
);

    // 1. NOT Gate Implementation
    // S = A, I[0] = 1, I[1] = 0
    structural_2x1_block mux_not (
        .data_in({1'b0, 1'b1}), // {I[1], I[0]} -> I[1]=0, I[0]=1
        .sel(A),
        .data_out(Y_not)
    );

    // 2. AND Gate Implementation
    // S = A, I[0] = 0, I[1] = B
    structural_2x1_block mux_and (
        .data_in({B, 1'b0}),    // {I[1], I[0]} -> I[1]=B, I[0]=0
        .sel(A),
        .data_out(Y_and)
    );

    // 3. OR Gate Implementation
    // S = A, I[0] = B, I[1] = 1
    structural_2x1_block mux_or (
        .data_in({1'b1, B}),    // {I[1], I[0]} -> I[1]=1, I[0]=B
        .sel(A),
        .data_out(Y_or)
    );

endmodule
  