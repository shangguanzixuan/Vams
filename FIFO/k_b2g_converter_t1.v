modue k_b2g_converter_t1 (gray, bin);
  parameter size = 4;
  output [size-1:0] gray;
  input [size-1:0] bin;

  assign gray = ((bin>>1) ^ bin);
endmodule
