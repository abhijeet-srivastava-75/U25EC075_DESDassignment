`timescale 1ns / 1ps

module tb_siso_register;
  //input 
  reg clk;
  reg reset;
  reg serial_in;

  // Outputs from the DUT (declared as wires)
  wire serial_out;
  
  // Instantiate the SISO Register module
    siso_register uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .serial_out(serial_out)
    );
  
  //clock generation 
  always begin
        #5 clk = ~clk;
    end
  
  
  // Stimulus Block
    initial begin
    // Initialize lines
    clk = 0;
    reset = 0;
    serial_in = 0;
      
   // Monitor internal shift operations (using uut internal path for clear logging)
        $monitor("Time = %0t | Reset = %b | Serial In = %b | Internal Reg = %b | Serial Out = %b", 
                 $time, reset, serial_in, uut.shift_reg, serial_out);   
      
      
      // 1. Apply Reset Pulse
        #10;
        reset = 1;
        #10;
        reset = 0;
        #5; // Aligning data placement nicely before the clock edge

        // 2. Load Phase: Stream in '1011' (LSB first: 1 -> 1 -> 0 -> 1)
        serial_in = 1; #10; // 1st clock edge: Reg becomes 1000
        serial_in = 1; #10; // 2nd clock edge: Reg becomes 1100
        serial_in = 0; #10; // 3rd clock edge: Reg becomes 0110
        serial_in = 1; #10; // 4th clock edge: Reg becomes 1011. Data is fully loaded!

        // 3. Retrieval Phase: Feed 0s to push remaining bits out completely
        serial_in = 0; 
        #40; 

        // End simulation
        $finish;
    end

endmodule