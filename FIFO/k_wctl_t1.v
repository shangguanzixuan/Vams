`timescale 1ns/1ps

module k_wctl_t1(
  output logic wrdy, wptr, wen,
  input logic wput, wq2_rptr,
  input logic wclk, wrst_n);

  always @ (posedge wclk or negedge wrst_n) begin
      if (!wrst_n)
          wptr <= '0;
      else
          wptr <= wptr ^ wen;
  end

  assign wrdy = ~(wptr ^ wq2_rptr);
  assign wen = wput & wrdy;
endmodule
