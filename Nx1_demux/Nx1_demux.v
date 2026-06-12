module demux_1xN_parameterized #(
  parameter SELECT_WIDTH = 2,
  parameter DATA_WIDTH = (1 << SELECT_WIDTH )
)(
  input wire Y,
  input wire [SELECT_WIDTH-1 : 0] S,
  output reg [DATA_WIDTH-1 : 0] I
);
  
  always@(*) begin 
    I = {DATA_WIDTH{1'b0}}; // Clear the entire bus to 0 first 
    I[S] = Y;   // Direct Indexing
  end 
endmodule 




module demux_1xN_dataflow #(
    parameter SELECT_WIDTH = 2,
    parameter DATA_WIDTH   = (1 << SELECT_WIDTH)
)(
    input  wire                    Y,
    input  wire [SELECT_WIDTH-1:0] S,
    output wire [DATA_WIDTH-1:0]   I
);
  
  genvar k;
  generate 
    for ( k = 0 ; k < DATA_WIDTH ; k = k + 1 ) begin : demux_logic 
      assign I[k] = ( S == k ) ? Y : 1'b0;
    end 
  endgenerate
endmodule 



module structural_1x2_block (
    input  wire Y,
    input  wire sel,
    output wire [1:0] data_out
);
    wire s_not;
    not (s_not, sel);
    and (data_out[0], Y, s_not);
    and (data_out[1], Y, sel);
  
endmodule


 
module demux_1xN_structural #(
    parameter SELECT_WIDTH = 2,
    parameter DATA_WIDTH   = (1 << SELECT_WIDTH)
)(
    input  wire                    Y,
    input  wire [SELECT_WIDTH-1:0] S,
    output wire [DATA_WIDTH-1:0]   I
);
  
  wire [DATA_WIDTH-1 : 0] tree_wires [ 0 : SELECT_WIDTH ];
  
  assign tree_wires[0][0] = Y;
  
  genvar layer , stage;
  generate
    for (layer = 0 ; layer < SELECT_WIDTH ; layer = layer + 1 ) begin : stage_layer
      localparam int block_in_layer = 1 << layer;
      for ( stage = 0 ; stage < block_in_layer ; stage = stage + 1 ) begin : demux_array
        structural_1x2_block inst (
          .Y( tree_wires[layer][stage] ),
          .sel( S[SELECT_WIDTH - 1 - layer] ),
          .data_out( {tree_wires[layer + 1][stage*2 + 1] , tree_wires[layer + 1][stage*2]} )
        );
      end
    end 	
  endgenerate
  
  assign I = tree_wires[SELECT_WIDTH];
  
endmodule  
       
      
      
      
