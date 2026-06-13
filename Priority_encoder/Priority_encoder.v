module priority_encoder_4x2_beh ( 
  input wire [ 3 : 0 ] D, 
  output reg [1 : 0 ] Y,
  output reg V
);
  
  always@(*) begin 
    if ( D[3] == 1 ) begin 
      Y = 2'b11;
      V = 1'b1;
    end else if ( D[2] == 1 ) begin 
      Y = 2'b10;
      V = 1'b1;
    end else if ( D[1] == 1 ) begin 
      Y = 2'b01;
      V = 1'b1;
    end else if ( D[0] == 1 ) begin
      Y = 2'b00;
      V = 1'b1;
    end else begin 
      Y = 2'b00;
      V = 1'b0;
    end 
  end
endmodule


module priority_encoder_4x2_dataflow (
    input  wire [3:0] D,
    output wire [1:0] Y,
    output wire       V
);

    assign V    = D[3] | D[2] | D[1] | D[0];
    assign Y[1] = D[3] | D[2];
    assign Y[0] = D[3] | (~D[2] & D[1]);

endmodule



module priority_encoder_4x2_structural (
    input  wire [3:0] D,
    output wire [1:0] Y,
    output wire       V
);

    wire d2_not;
    wire w_y0;

    // 1. Structural Inverter
    not G1 (d2_not, D[2]);

    // 2. AND gate path logic
    and G2 (w_y0, d2_not, D[1]);

    // 3. Output routing OR gates
    or  G3 (Y[1], D[3], D[2]); // Y[1] = D[3] | D[2]
    or  G4 (Y[0], D[3], w_y0); // Y[0] = D[3] | (~D[2] & D[1])
    or  G5 (V,    D[3], D[2], D[1], D[0]); // Valid bit logic

endmodule