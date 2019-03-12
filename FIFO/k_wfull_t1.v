module k_wfull_t1 (wfull, wptr, wq2_rptr, wclk, wrst_n);
  parameter addr_size = 4;
  output reg wfull;
  input [addr_size:0] wptr, wq2_rptr;
  input wclk, wrst_n;

  reg net_wfull;

  assign net_wfull = (wptr == {~wq2_rptr[addr_size:addr_size-1],
                               wq2_rptr[addr_size-2:0]});

  always @ (posedge wclk or negedge wrst_n) begin
      if (!wrst_n) begin
          wfull <= 1'b0;
      end else begin
          wfull <= net_wfull;
      end
  end
endmodule
