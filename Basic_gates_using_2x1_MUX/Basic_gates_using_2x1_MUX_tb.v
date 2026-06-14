module gates_using_mux_tb;

    reg  t_A, t_B;
    wire y_not, y_and, y_or;

    gates_using_mux uut (
        .A(t_A), .B(t_B),
        .Y_not(y_not), .Y_and(y_and), .Y_or(y_or)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    end

    initial begin
        $display("--- Verifying Universal MUX Gate Derivations ---");
        $display("A B | NOT(A) | AND | OR");
        $display("-----------------------");
        
        t_A = 0; t_B = 0; #10;
        $display("%b %b |   %b    |  %b  | %b", t_A, t_B, y_not, y_and, y_or);
        
        t_A = 0; t_B = 1; #10;
        $display("%b %b |   %b    |  %b  | %b", t_A, t_B, y_not, y_and, y_or);
        
        t_A = 1; t_B = 0; #10;
        $display("%b %b |   %b    |  %b  | %b", t_A, t_B, y_not, y_and, y_or);
        
        t_A = 1; t_B = 1; #10;
        $display("%b %b |   %b    |  %b  | %b", t_A, t_B, y_not, y_and, y_or);
        
        $finish;
    end

endmodule