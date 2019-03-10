`timescale 1ns/1ps

module k_dp_2deep_ram_t1 (q, d, wen, waddr, raddr, clk);
    parameter data_size = 8;
    parameter addr_size = 2;
    output wire [data_size-1:0] q;
    input wire [data_size-1:0] d;
    input wire wen, waddr, raddr, clk;

    reg [data_size-1:0] mem [0:addr_size-1];

    assign q = mem[raddr];

    always @ (posedge clk) begin
        if (wen) begin
            mem[waddr] <= d;
        end
    end
endmodule
