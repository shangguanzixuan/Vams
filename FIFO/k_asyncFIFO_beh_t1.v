module k_asyncFIFO_beh_t1 (
  // Outputs
  rdata, wfull, rempty,
  // Inputs
  wdata, wput, rget,
  // Input write control signals
  wclk, wrst_n,
  // Input read control signals
  rclk, rrst_n);

  parameter data_size = 8;
  parameter addr_size = 4;
  localparam len = 1<<addr_size;

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
  reg [addr_size:0] wptr, wq1_rptr, wq2_rptr, wq3_rptr;

  // Read Clock Domain inner nets
  reg [addr_size:0] rptr, rq1_wptr, rq2_wptr, rq3_wptr;

  // dual port deep ram
  reg [data_size-1:0] mem [0:len-1];

  // FIFO logic
  // write pointer and ram logic
  always @ (posedge wclk or negedge wrst_n) begin
      if (!wrst_n) begin
          wptr <= 0;
      end else if (wput && !wfull) begin
          mem[wptr[addr_size-1:0]] <= wdata;
          wptr <= wptr+1;
      end
  end

  // write pointer synchronization using 3 FF Synchronizer
  always @ (posedge wclk or negedge wrst_n) begin
      if (!wrst_n) begin
          wq1_rptr <= 0;
          wq2_rptr <= 0;
          wq3_rptr <= 0;
      end else begin
          wq1_rptr <= wptr;
          wq2_rptr <= wq1_rptr;
          wq3_rptr <= wq2_rptr;
      end
  end

  // read pointer and ram logic
  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n) begin
          rptr <= 0;
      end else if (rget && !rempty) begin
          rptr <= rptr+1;
      end
  end

  // read pointer synchronization using 3 FF Synchronizer
  always @ (posedge rclk or negedge rrst_n) begin
      if (!rrst_n) begin
          rq1_wptr <= 0;
          rq2_wptr <= 0;
          rq3_wptr <= 0;
      end else begin
          rq1_wptr <= rptr;
          rq2_wptr <= rq1_wptr;
          rq3_wptr <= rq2_wptr;
      end
  end

  // FIFO output logic
  assign rdata = mem[rptr[addr_size-1:0]];

  // FIFO empty flag
  assign rempty = (rptr == rq3_wptr);

  // FIFO Full flag
  assign wfull = ((wptr[addr_size-1:0] == wq3_rptr[addr_size-1:0]) &&
                  (wptr[addr_size] != wq3_rptr[addr_size]));

endmodule
