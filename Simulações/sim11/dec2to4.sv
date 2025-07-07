module dec2to4 (W, En, Y); // figure4.32.v
	input [1:0] W;
	input En;
	output [0:3] Y;

    assign = (En == 0) ? 4'b0000:
        (W == 2'b00) ? 4'b1000 :
        (W == 2'b01) ? 4'b0100 :
        (W == 2'b10) ? 4'b0010 :
        (W == 2'b11) ? 4'b0001 : 4'bxxxx;
endmodule
