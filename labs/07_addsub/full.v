module sum4bits (
  input cin,
  input signed [3:0] x, y,
  output signed [3:0] s,
  output ov);
  
  wire C[3:0];
  
  full_adder b0 ( cin, x[0], y[0], s[0], C[0]);
  full_adder b1 (C[0], x[1], y[1], s[1], C[1]);
  full_adder b2 (C[1], x[2], y[2], s[2], C[2]);
  full_adder b3 (C[2], x[3], y[3], s[3], C[3]);

  assign ov = C[2] ^ C[3];
endmodule

module full_adder(
    input Cin, X, Y,
    output S, Cout);
    assign S = X ^ Y ^ Cin;
    assign Cout = X & Y | Cin & (X ^ Y);    
endmodule

module dec7seg (
    input  [3:0] hex,
    output reg [6:0] segs); // some boards use active low, so you may need to invert the output
    always @(hex)        // gfedcba
      case (hex)         // 6543210
        4'b0000 : segs = ~7'b0111111; // 0
        4'b0001 : segs = ~7'b0000110; // 1
        4'b0010 : segs = ~7'b1011011; // 2
        4'b0011 : segs = ~7'b1001111; // 3
        4'b0100 : segs = ~7'b1100110; // 4
        4'b0101 : segs = ~7'b1101101; // 5
        4'b0110 : segs = ~7'b1111101; // 6
        4'b0111 : segs = ~7'b0000111; // 7
        4'b1000 : segs = ~7'b1111111; // 8
        4'b1001 : segs = ~7'b1101111; // 9
        4'b1010 : segs = ~7'b1110111; // A
        4'b1011 : segs = ~7'b1111100; // b
        4'b1100 : segs = ~7'b0111001; // C
        4'b1101 : segs = ~7'b1011110; // d
        4'b1110 : segs = ~7'b1111001; // E
        4'b1111 : segs = ~7'b1110001; // F
      endcase
endmodule

