module mux_8x1 (
  input wire [7:0] in , 
  input wire [2:0] sel,
  output reg out
);
  
  // function defintion 
  function mux_2x1;
    input i0 , i1, s;
    begin 
      mux_2x1 = s ? i1 : i0;
    end 
  endfunction 
  
  //task definition
  task mux_4x1;
    output out_4;
    input [3:0] d;
    input [1:0] s;
    begin 
      case(s)
        2'b00 : out_4 = mux_2x1(d[0] , d[1] , 1'b0);
        2'b01 : out_4 = mux_2x1(d[0] , d[1] , 1'b1);
        2'b10 : out_4 = mux_2x1(d[2] , d[3] , 1'b0);
        2'b11 : out_4 = mux_2x1(d[2] , d[3] , 1'b1);
      endcase 
    end 
  endtask 
  
  // now make the 8x1 MUX 
  reg lower_4_out;
  reg upper_4_out;
  
  always@(*) begin 
    mux_4x1(lower_4_out , in[3:0] , sel[1:0] );
    mux_4x1(upper_4_out , in[7:4] , sel[1:0] );
    out = mux_2x1(lower_4_out , upper_4_out , sel[2] ) ;
    
  end
endmodule 