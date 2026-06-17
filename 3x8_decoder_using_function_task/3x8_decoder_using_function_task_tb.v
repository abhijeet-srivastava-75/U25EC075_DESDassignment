`timescale 1ns / 1ps

module tb_decoder_3x8;

    // Inputs
    reg [2:0] in;
    reg en;

    // Outputs
    wire [7:0] out;

    // Instantiate the Unit Under Test (UUT)
    decoder_3x8 uut (
        .in(in), 
        .en(en), 
        .out(out)
    );

    // --- Fixed Verilog Task ---
    task drive_stimulus;
        input [2:0] test_in;
        input       test_en;
        begin
            in = test_in;
            en = test_en;
            #1; // Give a tiny 1ns delay for the simulator to settle the outputs
            $display("Enable = %b | Input = %b (%0d) | Output = %b", en, in, in, out);
            #9; // Finish the rest of the 10ns time slot
        end
    endtask

    // Stimulus process
    initial begin
        // Optional but highly recommended: Creates the VCD file properly
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_decoder_3x8);

        $display("Starting 3x8 Decoder Test...");
        $display("---------------------------------------");
        
        // Case 1: Decoder Disabled
        drive_stimulus(3'b011, 1'b0);
        drive_stimulus(3'b111, 1'b0);
        
        // Case 2: Decoder Enabled (Testing all 8 combinations)
        drive_stimulus(3'b000, 1'b1);
        drive_stimulus(3'b001, 1'b1);
        drive_stimulus(3'b010, 1'b1);
        drive_stimulus(3'b011, 1'b1);
        drive_stimulus(3'b100, 1'b1);
        drive_stimulus(3'b101, 1'b1);
        drive_stimulus(3'b110, 1'b1);
        drive_stimulus(3'b111, 1'b1);

        $display("---------------------------------------");
        #10; // Extra padding so the final display flushes to the log console
        $finish;
    end
      
endmodule