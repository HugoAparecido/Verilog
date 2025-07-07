module mux8to2 (W, S, f); 
  input [7:0] W;
  input [1:0] S;
  output [1:0] f;

  assign f = (S == 2'b00) ? W[1:0] :
        (S == 2'b01) ? W[3:2] :
        (S == 2'b10) ? W[5:4] :
        (S == 2'b11) ? W[7:6] : 1'bx;
endmodule