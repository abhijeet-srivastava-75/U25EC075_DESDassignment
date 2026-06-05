module encoder_4x2_behavioral(
  input wire [3:0] D, output reg [1:0] Y
);
  
  always@(*) begin
    case (D)
      4'b0001 : Y = 2'b00;
      4'b0010 : Y = 2'b01;
      4'b0100 : Y = 2'b10;
      4'b1000 : Y = 2'b11;
      default : Y = 2'b00;
    endcase
  end
endmodule


module encoder_4x2_dataflow(
  input wire [3:0] D, output wire [1:0] Y
);
  
  assign Y[0] = D[1] | D[3];
  assign Y[1] = D[2] | D[3];
  
endmodule


module encoder_4x2_structural(
  input wire [3:0] D, output wire [1:0] Y
);
  
  or G1 (Y[0] , D[1] , D[3]);
  or G2 (Y[1] , D[2] , D[3]);
  
endmodule