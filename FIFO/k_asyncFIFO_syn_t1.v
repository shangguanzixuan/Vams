module k_asyncFIFO_syn_t1 (
  // Outputs
  rdata, rempty, wfull,
  // Inputs
  wdata, wput, rget,
  // Input write control signals
  wclk, wrst_n,
  // Input read control signals
  rclk, rrst_n);

  parameter data_size = 8;
  parameter addr_size = 4;

  // Write Clock Domain Interface
  output wfull;
  input [data_size-1:0] wdata;
  input wput;
  input wclk, wrst_n;

  // Read Clock Domain Interface
  output [data_size-1:0] rdata;
  output rempty;
  input rget;
  input rclk, rrst_n;

  // Write Clock Domain inner nets
  wire [addr_size:0] wptr, wq2_rptr;
  wire [addr_size-1:0] waddr;

  // Read Clock Domain inner nets
  wire [addr_size:0] rptr, rq2_wptr;
  wire [addr_size-1:0] raddr;

  // Instantiate write to read 2 FF Synchronizer
  k_Sync2_w2r_t1 #(.addr_size(addr_size)) k_Sync2_w2r_t1 (.rq2_wptr(rq2_wptr),
                                                          .wptr(wptr),
                                                          .rclk(rclk),
                                                          .rrst_n(rrst_n));

  // Instantiate read to write 2 FF Synchronizer
  k_Sync2_r2w_t1 #(.addr_size(addr_size)) k_Sync2_r2w_t1 (.wq2_rptr(wq2_rptr),
                                                          .rptr(rptr),
                                                          .wclk(wclk),
                                                          .wrst_n(wrst_n));

  // Instantiate Write Clock Domain Logic
  k_wctl_t2 #(.addr_size(addr_size)) k_wctl_t2 (.wfull(wfull),
                                                .waddr(waddr),
                                                .wptr(wptr),
                                                .wq2_rptr(wq2_rptr),
                                                .wput(wput),
                                                .wclk(wclk),
                                                .wrst_n(wrst_n));

  // Instantiate Read Clock Domain Logic
  k_rctl_t2 #(.addr_size(addr_size)) k_rctl_t2 (.rempty(rempty),
                                                .raddr(raddr),
                                                .rptr(rptr),
                                                .rq2_wptr(rq2_wptr),
                                                .rget(rget),
                                                .rclk(rclk),
                                                .rrst_n(rrst_n));

  // Instantiate dual port n deep RAM
  k_dp_ndeep_ram_t1 #(.data_size(data_size),
                      .addr_size(addr_size)) k_dp_ndeep_ram_t1
                                             (.rdata(rdata),
                                              .wdata(wdata),
                                              .waddr(waddr),
                                              .raddr(raddr),
                                              .wput(wput),
                                              .wfull(wfull),
                                              .wclk(wclk));

endmodule
