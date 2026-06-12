module mux_Nx1_parameterized #(
  parameter SELECT_WIDTH = 2,
  parameter DATA_WIDTH = ( 1 << SELECT_WIDTH ) 
)(
  input wire [SELECT_WIDTH-1 : 0] S,
  input wire [DATA_WIDTH-1 : 0] I,
  output reg Y
);
  
  always@(*) begin 
    Y = I[S];
  end 
endmodule 



module mux_Nx1_dataflow #(
  parameter SELECT_WIDTH = 2,
  parameter DATA_WIDTH = ( 1 << SELECT_WIDTH ) 
)(
  input wire [SELECT_WIDTH-1 : 0] S,
  input wire [DATA_WIDTH-1 : 0] I,
  output wire Y
);
  
  wire [DATA_WIDTH-1 : 0] channel_match ;
  genvar k;
  
  generate 
    for ( k = 0 ; k < DATA_WIDTH ; k = k + 1 ) begin : mux_logic 
      assign channel_match[k] = ( S == k ) ? I[k] : 1'b0;
    end 
  endgenerate
    
  assign Y = |channel_match;
endmodule 
    
    

    module mux_Nx1_structural #(
      parameter SELECT_WIDTH = 2,
      parameter DATA_WIDTH = ( 1 << SELECT_WIDTH )
    )(
      input  wire [DATA_WIDTH-1:0]   I,
      input  wire [SELECT_WIDTH-1:0] S,
      output wire Y
);
      wire [DATA_WIDTH-1 : 0] tree_wires [0 : SELECT_WIDTH];
      
      assign tree_wires[0] = I;
      genvar layer , stage;
      generate 
        for ( layer = 0 ; layer < SELECT_WIDTH ; layer = layer + 1 ) begin : stage_layer
          localparam int blocks_in_layer = 1 << ( SELECT_WIDTH - 1 - layer );
          
          for( stage = 0 ; stage < blocks_in_layer ; stage = stage + 1) begin : mux_array
            structural_2x1_block inst (
              .data_in( {tree_wires[layer][stage*2 + 1], tree_wires[layer][stage*2]} ),
              .sel(S[layer]),
              .data_out(tree_wires[layer + 1][stage])
          );
            end
        end
        endgenerate

    // The very final wire at the tip of the tree is our ultimate output Y
    assign Y = tree_wires[SELECT_WIDTH][0];

endmodule

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