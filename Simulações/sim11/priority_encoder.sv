module priority_encoder (
  input [3:0] W,
  output [1:0] Y,
  output Z);

  assign Y = (W[3] == 1) ? 2'b11 :
    (W[2] == 1) ? 2'b10 :
    (W[1] == 1) ? 2'b01 :
    (W[0] == 1) ? 2'b00 : 2'bxx;

  assign Z = |W;
endmodule