module k_ptr_t1 (ptr, addr, inc, rdy, clk, rst_n);
  parameter addr_size = 4;
  output [addr_size:0] ptr;
  output [addr_size-1:0] addr;
  input inc, rdy_n;
  input clk, rst_n;

  reg [addr_size:0] bin, net_ptr;
  wire [addr_size:0] bnxt, gnxt;

  always @ (posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          net_ptr <= 0;
          bin <= 0;
      end else begin
          net_ptr <= gnxt;
          bin <= bnxt;
      end
  end

  assign bnxt = bin + (inc & ~rdy);

  // Instantiate Binary to gray code converter
  k_b2g_converter_t1 #(.size(addr_size)) k_b2g_converter_t1 (.gray(gnxt),
                                                             .bin(bnxt));

  assign ptr = net_ptr;
  assign addr = bin[data_size-1:0];
endmodule
