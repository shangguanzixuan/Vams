module k_rctl_t2 (rempty, raddr, rptr, rq2_wptr, rget, rclk, rrst_n);
  parameter addr_size = 4;
  output reg rempty;
  output [addr_size-1:0] raddr;
  output reg [addr_size:0] rptr;
  input [addr_size:0] rq2_wptr;
  input rget;
  input rclk, rrst_n;

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
