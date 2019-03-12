module k_Dual_GrayCounter_t1 (gray1, addr, inc, ready, clk, rst_n);
  paramter data_size = 4;
  output [data_size-1:0] gray1;
  output [data_size-2:0] addr;
  input inc, ready;
  input clk, rst_n;

  wire [data_size-1:0] bin, bnxt, gnxt, ptr;
  wire msbgray2, msbgray2_q1;

  always @ (posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          ptr <= 0;
          msbgray2_q1 <= 0;
      end else begin
          ptr <= gnxt;
          msbgray2_q1 <= msbgray2;
      end
  end

  // instantiate gray to binary code converter
  k_g2b_converter_t1 #(.size(data_size)) g2b (.bin(bin),
                                         .gray(ptr));

  assign bnxt = (inc && ready) ? bin + inc : bin;

  // instantiate binary to gray code converter
  k_b2g_converter_t1 #(.size(size)) b2g (.gray(gnxt),
                                         .bin(bnxt));

  assign gray1 = ptr;
  assign msbgray2 = ptr[data_size-1] ^ ptr[data_size-2];
  assign addr = {msbgray2_q1, ptr[data_size-3:0]};
endmodule
