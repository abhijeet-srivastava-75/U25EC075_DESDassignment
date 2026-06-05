module mux_2x1_beh(
  input wire [1:0] I, input wire S , output reg Y 
);
  
  always@(*) begin 
    case (S)
    1'b0 : Y = I[0];
    1'b1 : Y = I[1];
    endcase
  end 
endmodule
      
      module mux_2x1_dataflow(
        input wire [1:0] I , input wire S , output wire Y
      );
        
        assign Y = (I[0] & ~S) | (I[1] & S);
      endmodule
      
      module mux_2x1_structural(
        input wire [1:0] I , input wire S , output wire Y
      );
        
        wire S_not , Y1 , Y2;
        not G1 (S_not , S);
        
        and G2 ( Y1 , I[0] , S_not);
        and G3 ( Y2 , I[1] , S);
        
        or G4 (Y , Y1 , Y2);
        
      endmodule
     