module gray_encoder_4bit_beh ( 
  input wire [3 : 0] B,
  output reg [3 : 0] G
);
  
  always@(*) begin 
    G = B ^ ( B >> 1 );
  end 
endmodule 


module gray_encoder_4bit_dataflow (
    input  wire [3:0] B,
    output wire [3:0] G
);
  assign G[3] = B[3];
  assign G[2] = B[2] ^ B[3];
  assign G[1] = B[1] ^ B[2];
  assign G[0] = B[0] ^ B[1];
  
endmodule 



module gray_encoder_4bit_structural (
    input  wire [3:0] B,
    output wire [3:0] G
);

    // MSB passes through untouched
    assign G[3] = B[3];

    // Structural XOR gate instantiations: xor (output, input1, input2);
    xor G2 (G[2], B[3], B[2]);
    xor G1 (G[1], B[2], B[1]);
    xor G0 (G[0], B[1], B[0]);

endmodule