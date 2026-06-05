module mux_4x1_beh (
    input  wire [3:0] I, 
    input  wire [1:0] S, 
    output reg        Y  
);

    always @(*) begin
        case (S)
            2'b00   : Y = I[0];
            2'b01   : Y = I[1]; 
            2'b10   : Y = I[2]; 
            2'b11   : Y = I[3]; 
            default : Y = 1'b0;
        endcase
    end

endmodule

module mux_4x1_dataflow (
    input  wire [3:0] I,
    input  wire [1:0] S,
    output wire       Y
);

    assign Y = (I[0] & ~S[1] & ~S[0]) |
               (I[1] & ~S[1] &  S[0]) |
               (I[2] &  S[1] & ~S[0]) |
               (I[3] &  S[1] &  S[0]);

endmodule


module mux_4x1_structural (
    input  wire [3:0] I,
    input  wire [1:0] S,
    output wire       Y
);

    
    wire s1_not, s0_not;
    wire w0, w1, w2, w3;


    not U1 (s1_not, S[1]);
    not U2 (s0_not, S[0]);


    and G0 (w0, I[0], s1_not, s0_not); 
    and G1 (w1, I[1], s1_not, S[0]);  
    and G2 (w2, I[2], S[1],   s0_not);
    and G3 (w3, I[3], S[1],   S[0]);  

    or  G4 (Y, w0, w1, w2, w3);

endmodule