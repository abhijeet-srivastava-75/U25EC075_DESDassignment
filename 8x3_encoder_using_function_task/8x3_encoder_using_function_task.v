module encoder_8x3 (
  input wire [7:0] in,
  output reg [2:0] out,
  output reg valid
);
  
  function [1:0] enc_4x2;
    input [3:0] d;
    begin 
      case(d)
        4'b0001 : enc_4x2 = 2'b00;
        4'b0010: enc_4x2 = 2'b01; 
        4'b0100: enc_4x2 = 2'b10; 
        4'b1000: enc_4x2 = 2'b11; 
        default: enc_4x2 = 2'b00; 
       endcase
     end
  endfunction
  
  task enc_8x3;
    output [2:0] t_out;
    input [7:0] t_in;
    begin
      // Check if the active bit is in the upper half (bits 7, 6, 5, or 4
      if(t_in[7:4] != 4'b0000) begin 
        t_out = {1'b1 , enc_4x2(t_in[7:4])};
        end
        // Otherwise, the active bit must be in the lower half (bits 3, 2, 1, or 0)
        else begin
         // MSB is 0 because index is < 4.
         // Call function for the remaining 2 bits.
         t_out = {1'b0, enc_4x2(t_in[3:0])};
       end
     end
  endtask
  
  reg [2:0] local_out;

   always @(*) begin
   // Call our task using positional mapping
   enc_8x3(local_out, in);
        
    // Drive the module output
    out = local_out;
    valid = (in != 8'b0000);
    end
endmodule