module decoder_3x8 (
  input wire [2:0] in,
  input wire en,
  output reg [7:0] out
);
  
  function [7:0] decode_logic;
    input [2:0] select;
    input en;
    begin
      if ( en ) begin 
        decode_logic = 8'b00000001 << select;
      end else begin 
        decode_logic = 8'b00000000;
      end 
    end 
  endfunction 
  
  always@(*) begin 
    out = decode_logic(in , en );
  end 
endmodule