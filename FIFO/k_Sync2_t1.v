`timescale 1ns/1ps

module k_Sync2_t1 (q, d, clk, rst_n);
    output reg q;
    input wire d, clk, rst_n;

    reg q1;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1 <= 1'b0;
            q <= 1'b0;
        end else begin
            q1 <= d;
            q <= q1;
        end
    end
endmodule
