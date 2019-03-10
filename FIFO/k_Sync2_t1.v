`timescale 1ns/1ps

module k_Sync2_t1 (q, d, clk, rst_n);
    output reg q;
    input wire d, clk. rst_n;

    wire q1;

    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            q <= '0;
            q1 <= '0;
        else
            q1 <= d;
            q <= q1;
    end
endmodule
