module siso_register (
  input wire clk,
  input wire reset,
  input wire serial_in,
  output reg serial_out
);
  
  // internal 4 bit register that is like q 
  reg [3:0] shift_reg;
  
  always @( posedge clk ) begin 
    if( reset ) begin 
      shift_reg <= 4'b0000;
    end 
    else begin 
      shift_reg <= {serial_in , shift_reg[3:1]};
    end 
  end 
  
  assign serial_out = shift_reg[0];
endmodule 
      