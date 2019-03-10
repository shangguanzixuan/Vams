`timescale 1ns/1ps

module k_Sync2_t1 (q, d, clk, rst_n);
    output q;
    input d, clk, rst_n;

    reg q;
    reg q1;

    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            q <= 1'b0;
            q1 <= 1'b0;
        else
            q1 <= d;
            q <= q1;
    end
endmodule
