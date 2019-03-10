`timescale 1ns/1ps

module k_SyncFIFO_t1 (
  // Outputs
  rdata, rrdy, wrdy,
  // Inputs
  wdata, wput, rget,
  // Input write control signals
  wclk, wrst_n,
  // Input read control signals
  rclk, rrst_n);
  parameter data_size = 8;

  // Write Clock Domain Interface
  output wire wrdy;
  input wire [data_size-1:0] wdata;
  input wire wput;
  input wire wclk, wrst_n;

  // Read Clock Domain Interface
  output reg [data_size-1:0] rdata;
  output wire rrdy;
  input wire rget;
  input wire rclk, rrst_n;

  // Write Clock Domain inner nets
  wire wen, wptr, wq2_rptr;

  // Read Clock Domain inner nets
  wire rptr, rq2_wptr;

  // Write Clock 2 FF Synchronizer Instantiation
  k_Sync2_t1    r2w_sync  (.q(wq2_rptr),
                           .d(rptr),
                           .clk(wclk),
                           .rst_n(wrst_n));

   // Read Clock 2 FF Synchronizer Instantiation
   k_Sync2_t1    w2r_sync  (.q(rq2_wptr),
                            .d(wptr),
                            .clk(rclk),
                            .rst_n(rrst_n));

  // Write Control Instantiation
  k_wctl_t1   wctl  (.wrdy(wrdy),
                     .wptr(wptr),
                     .wen(wen),
                     .wput(wput),
                     .wq2_rptr(wq2_rptr),
                     .wclk(wclk),
                     .wrst_n(wrst_n));

  // Read Control Instantiation
  k_rctl_t1   rctl  (.rrdy(rrdy),
                     .rptr(rptr),
                     .rget(rget),
                     .rq2_wptr(rq2_wptr),
                     .rclk(rclk),
                     .rrst_n(.rrst_n));

  // Dual Port 2 deep RAM Instantiation
  k_dp_2deep_ram_t1   dpram   (.q(rdata),
                               .d(wdata),
                               .wen(wen),
                               .waddr(wptr),
                               .raddr(rptr),
                               .clk(wclk));

  endmodule
