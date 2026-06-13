module gray_encoder_4bit_tb;

    reg  [3:0] t_B;
    wire [3:0] g_beh;
    wire [3:0] g_df;
    wire [3:0] g_str;

    // Instantiate all three modules
    gray_encoder_4bit_beh uut_beh (.B(t_B), .G(g_beh));
    gray_encoder_4bit_dataflow uut_df (.B(t_B), .G(g_df));
    gray_encoder_4bit_structural uut_str (.B(t_B), .G(g_str));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    initial begin
        $display("--- Starting 4-Bit Gray Encoder Verification ---");
        $display("Binary | Gray (Beh) | Gray (DF) | Gray (Str)");
        $display("--------------------------------------------");
        
        // Loop through all 16 combinations
        for (integer i = 0; i < 16; i = i + 1) begin
            t_B = i; #10;
            $display(" %b  |   %b   |   %b  |   %b", t_B, g_beh, g_df, g_str);
        end
        
        $display("--- Verification Complete ---");
        $finish;
    end

endmodule