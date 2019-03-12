module k_Sync2_t2 (q, d, clk, rst_n);
  parameter addr_size = 4;
  output reg [addr_size-1:0] q;
  input [addr_size-1:0]d;
  input clk, rst_n;

  reg [addr_size-1:0] q1;

  always @ (posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          q1 <= 0;
          q <= 0;
      end else begin
          q1 <= d;
          q <= q1;
      end
  end
endmodule
