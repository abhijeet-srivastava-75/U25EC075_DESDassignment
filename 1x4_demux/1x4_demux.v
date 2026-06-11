module demux_1x4_beh(
  input wire Y , input wire [1:0] S , output reg [3:0] I
);
  
  always@(*) begin 
    if ( S == 2'b00 ) begin 
      I = {3'b000 , Y};
    end else if ( S == 2'b01 ) begin
      I = {2'b00 , Y , 1'b0};
    end else if (S == 2'b10) begin
            I = {1'b0, Y, 2'b00}; // Sets I[2] = Y
        end else begin
            I = {Y, 3'b000}; // Sets I[3] = Y
        end
    end
endmodule


module demux_1x4_dataflow(
  input wire Y , input wire [1:0] S , output wire [3:0] I
);
  assign I[0] = Y & ~S[0] & ~S[1] ; 
  assign I[1] = Y & ~S[1] &  S[0];
  assign I[2] = Y &  S[1] & ~S[0];
  assign I[3] = Y &  S[1] &  S[0];

endmodule

module demux_1x4_structural(
  input wire Y , input wire [1:0] S , output wire [3:0] I
);
  
  wire s1_not, s0_not;

    
    not G1 (s1_not, S[1]);
    not G2 (s0_not, S[0]);

    
    and G3 (I[0], Y, s1_not, s0_not); 
    and G4 (I[1], Y, s1_not, S[0]);
    and G5 (I[2], Y, S[1],   s0_not);
    and G6 (I[3], Y, S[1],   S[0]); 

endmodule