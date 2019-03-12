module k_rctl_t2 (rempty, raddr, rptr, rq2_wptr, rget, rclk, rrst_n);
  parameter addr_size = 4;
  output rempty;
  output [addr_size-1:0] raddr;
  output [addr_size:0] rptr;
  input [addr_size:0] rq2_wptr;
  input rget;
  input rclk, rrst_n;

  reg net_rempty;
  reg [addr_size:0] net_rptr;
  
  // Instantiate read pointer and address logic
  k_ptr_t1 #(.addr_size(addr_size)) k_ptr_t1 (.ptr(net_rptr),
                                              .addr(raddr),
                                              .inc(rget),
                                              .rdy(net_rempty),
                                              .clk(rclk),
                                              .rst_n(rrst_n));

  // Instantiate empty flag logic
  k_rempty_t1 #(.addr_size(addr_size)) k_rempty_t1 (.rempty(net_rempty),
                                                    .rptr(net_rptr),
                                                    .rq2_wptr(rq2_wptr),
                                                    .rclk(rclk),
                                                    .rrst_n(rrst_n));

  assign rptr = net_rptr;
  assign rempty = net_rempty;
endmodule
