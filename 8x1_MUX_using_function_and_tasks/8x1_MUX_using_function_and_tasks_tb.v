module tb_mux_8x1;
    reg [7:0] in;
    reg [2:0] sel;
    wire out;

    // Instantiate the 8x1 MUX
    mux_8x1 uut (
        .in(in),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Dump waves so EDA Playground can plot them
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mux_8x1);

        // Test Case 1: Give every pin a distinct pattern
        // Let's make in = 8'b10101010
        in = 8'b10101010; 
        
        // Let's cycle through all select lines from 0 to 7
        sel = 3'b000; #10; // Should pick in[0] -> out should be 0
        sel = 3'b001; #10; // Should pick in[1] -> out should be 1
        sel = 3'b010; #10; // Should pick in[2] -> out should be 0
        sel = 3'b011; #10; // Should pick in[3] -> out should be 1
        sel = 3'b100; #10; // Should pick in[4] -> out should be 0
        sel = 3'b101; #10; // Should pick in[5] -> out should be 1
        sel = 3'b110; #10; // Should pick in[6] -> out should be 0
        sel = 3'b111; #10; // Should pick in[7] -> out should be 1

        $finish;
    end
endmodule