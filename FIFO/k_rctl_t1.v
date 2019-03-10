`timescale 1ns/1ps

module k_rctl_t1(
  output rrdy, rptr,
  input rget, rq2_wptr,
  input rclk, rrst_n);

  reg rrdy, rptr;

  wire ren;

  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n)
          rptr <= 1'b0;
      else
          rptr <= rptr ^ ren;
  end

  assign rrdy = rptr ^ rq2_wptr;
  assign ren = rget & rrdy;
endmodule
