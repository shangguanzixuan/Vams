`timescale 1ns/1ps

module k_dp_2deep_ram_t1 (q, d, wen, waddr, raddr, clk);
    parameter data_size = 8;
    parameter addr_size = 1;
    output logic [data_size-1:0] q;
    input logic [data_size-1:0] d;
    input logic wen, waddr, raddr, clk;

    logic [data_size-1:0] mem [0:addr_size];

    always @ (posedge clk) begin
        if (wen)
            mem[waddr] <= d;
    end

    assign q = mem[raddr];
endmodule
