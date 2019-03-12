`timescale 1ns/1ps

module k_dp_2deep_ram_t1 (q, d, wen, waddr, raddr, clk);
    parameter data_size = 8;
    parameter addr_size = 1;
    localparam  len = 1<<addr_size;
    output [data_size-1:0] q;
    input [data_size-1:0] d;
    input wen;
    input [addr_size-1:0] waddr, raddr;
    input clk;

    reg [data_size-1:0] mem [0:len-1];

    assign q = mem[raddr];

    always @ (posedge clk) begin
        if (wen) begin
            mem[waddr] <= d;
        end
    end
endmodule
