`timescale 1ns/1ps

module k_rctl_t1(
  output reg rrdy, rptr,
  input wire rget, rq2_wptr,
  input wire rclk, rrst_n);

  wire ren;

  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n)
          rptr <= '0;
      else
          rptr <= rptr ^ ren;
  end

  assign rrdy = rptr ^ rq2_wptr;
  assign ren = rget & rrdy;
endmodule
