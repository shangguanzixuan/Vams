module k_Sync2_r2w_t1 (wq2_rptr, rptr, wclk, wrst_n);
  parameter addr_size = 4;
  output reg [addr_size:0] wq2_rptr;
  input [addr_size:0] rptr;
  input wclk, wrst_n;

  reg [addr_size:0] wq1_rptr;

  always @ (posedge wclk or negedge wrst_n) begin
      if (!wrst_n) begin
          wq1_rptr <= 0;
          wq2_rptr <= 0;
      end else begin
          wq1_rptr <= rptr;
          wq2_rptr <= wq1_rptr;
      end
  end
endmodule
