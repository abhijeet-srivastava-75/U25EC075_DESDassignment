module mux_4x1_tb;
  reg [3:0] t_I;
  reg [1:0] t_S;
  
  wire y_beh;
  wire y_df;
  wire y_str;
  
  mux_4x1_beh uut_beh(
    .I(t_I),
        .S(t_S),
        .Y(y_beh)
    );

    
    mux_4x1_dataflow uut_df (
        .I(t_I),
        .S(t_S),
        .Y(y_df)
    );

 
    mux_4x1_structural uut_str (
        .I(t_I),
        .S(t_S),
        .Y(y_str)
    );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
        // --- Case 0: S = 00 (Output must follow I[0]) ---
        t_S = 2'b00;
        t_I = 4'b1110; #10; // I[0]=0 -> Expect Outputs = 0
        t_I = 4'b0001; #10; // I[0]=1 -> Expect Outputs = 1

        // --- Case 1: S = 01 (Output must follow I[1]) ---
        t_S = 2'b01;
        t_I = 4'b1101; #10; // I[1]=0 -> Expect Outputs = 0
        t_I = 4'b0010; #10; // I[1]=1 -> Expect Outputs = 1

        // --- Case 2: S = 10 (Output must follow I[2]) ---
        t_S = 2'b10;
        t_I = 4'b1011; #10; // I[2]=0 -> Expect Outputs = 0
        t_I = 4'b0100; #10; // I[2]=1 -> Expect Outputs = 1

        // --- Case 3: S = 11 (Output must follow I[3]) ---
        t_S = 2'b11;
        t_I = 4'b0111; #10; // I[3]=0 -> Expect Outputs = 0
        t_I = 4'b1000; #10; // I[3]=1 -> Expect Outputs = 1
        
        $finish; // End simulation
    end

endmodule