module tb_encoder_8x3;
    reg [7:0] in;
    wire [2:0] out;

    // Instantiate your 8x3 encoder
    encoder_8x3 uut (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_encoder_8x3);

        // Test every input index one by one (only 1 bit high at a time)
        in = 8'b00000001; #10; // Expected out = 000 (0)
        in = 8'b00000010; #10; // Expected out = 001 (1)
        in = 8'b00000100; #10; // Expected out = 010 (2)
        in = 8'b00001000; #10; // Expected out = 011 (3)
        in = 8'b00010000; #10; // Expected out = 100 (4)
        in = 8'b00100000; #10; // Expected out = 101 (5)
        in = 8'b01000000; #10; // Expected out = 110 (6)
        in = 8'b10000000; #10; // Expected out = 111 (7)

        $finish;
    end
endmodule