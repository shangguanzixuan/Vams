module k_Sync2_w2r_t1 (rq2_wptr, wptr, rclk, rrst_n);
  parameter addr_size = 4;
  output reg [addr_size:0] rq2_wptr;
  input [addr_size:0] wptr;
  input rclk, rrst_n;

  reg [addr_size:0] rq1_wptr;

  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n) begin
          rq1_wptr <= 0;
          rq2_wptr <= 0;
      end else begin
          rq1_wptr <= wptr;
          rq2_wptr <= rq1_wptr;
      end
  end
endmodule
