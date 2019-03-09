`timescale 1ns/1ps

module k_rctl_t1(
  output logic rrdy, rptr,
  input logic rget, rq2_wptr,
  input logic rclk, rrst_n);

  logic ren;

  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n)
          rptr <= '0;
      else
          rptr <= rptr ^ ren;
  end

  assign rrdy = rptr ^ rq2_wptr;
  assign ren = rget & rrdy;
endmodule
