module k_wctl_t2 (wfull, waddr, wptr, wq2_rptr, wrdy, wclk, wrst_n);
  parameter addr_size = 4;
  output wfull;
  output [addr_size-1:0] waddr;
  output [addr_size:0] wptr;
  input [addr_size:0] wq2_rptr;
  input wrdy;
  input wclk, wrst_n;

  reg net_wfull;
  reg [addr_size:0] net_wptr;

  // Instantiate Write Pointer and Memory Address Block
  k_ptr_t1 #(.addr_size(addr_size)) k_ptr_t1 (.ptr(net_wptr),
                                              .addr(waddr),
                                              .inc(wput),
                                              .rdy(wrdy),
                                              .clk(wclk),
                                              .rst_n(wrst_n));

  // Instantiate Full Flag Logic
  k_wfull_t1 #(.addr_size(addr_size)) k_wfull_t1 (.wfull(net_wfull),
                                                  .wptr(net_wptr),
                                                  .wq2_rptr(wq2_rptr),
                                                  .wclk(wclk),
                                                  .wrst_n(wrst_n));

  assign wfull = net_wfull;
  assign wptr = net_wptr;
endmodule
