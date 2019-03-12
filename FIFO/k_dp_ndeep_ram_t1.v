module k_dp_ndeep_ram_t1 (rdata, wdata, waddr, raddr, wput, wfull, wclk);
  parameter data_size = 8;
  parameter addr_size = 4;
  output [data_size-1:0] rdata;
  input [data_size-1:0] wdata;
  input [addr_size-1:0] waddr, raddr;
  input wput, wfull;
  input wclk;

  localparam  len = 1 << addr_size;

  reg [data_size-1:0] mem [0:len-1];

  assign rdata = mem[raddr];

  always @ (posedge wclk) begin
      if (wput && !wfull) begin
          mem[waddr] <= wdata;
      end
  end
endmodule
