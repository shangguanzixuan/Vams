module k_rempty_t1(rempty, rptr, rq2_wptr, rclk, rrst_n);
  parameter addr_size = 4;
  output reg rempty;
  input [addr_size:0] rptr, rq2_wptr;
  input rclk, rrst_n;

  reg net_rempty;

  assign net_rempty = (rptr == rq2_wptr);

  always @ (posedge clk or negedge rrst_n) begin
      if (!rrst_n) begin
          rempty <= 1'b1;
      end else begin
          rempty <= net_rempty;
      end
  end
endmodule
