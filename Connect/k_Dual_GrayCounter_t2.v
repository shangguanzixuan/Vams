module k_Dual_GrayCounter_t2 (gray1, addr, inc, ready, clk, rst_n);
  paramter data_size = 4;
  output [data_size-1:0] gray1;
  output [data_size-2:0] addr;
  input inc, ready;
  input clk, rst_n;

  reg [data_size-1:0] bin, ptr;
  wire [data_size-1:0] bnxt, gnxt;

  always @ (posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          ptr <= 0;
          bin <= 0;
      end else begin
          ptr <= gnxt;
          bin <= bnxt;
      end
  end

  assign bnxt = (inc && ready) ? bin + inc : bin;

  // instantiate binary to gray code converter
  k_b2g_converter_t1 #(.size(data_size)) b2g (.gray(gnxt),
                                         .bin(bnxt));

  assign gray1 = ptr;
  assign addr = bin[data_size-2:0];
endmodule
