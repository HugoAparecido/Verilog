module counter(
  input clk, rst,
  output reg [2:0] count);
  wire [2:0] ncount;
  //module tff(input clk, rst, t, output reg q, nq);
  tff q0 (clk, rst,      1'b1, count[0], ncount[0]);
  tff q1 (clk, rst,  count[0], count[1], ncount[1]);
  tff q2 (clk, rst, ncount[1], count[2], ncount[2]);
endmodule