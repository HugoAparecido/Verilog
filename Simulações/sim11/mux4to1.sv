module mux4to1 (W, S, f); // figure4.28.v
	input [0:3] W;
	input [1:0] S;
	output f;
		
	assign f = (S == 2'b00) ? W[0] :
        (S == 2'b01) ? W[1] :
        (S == 2'b10) ? W[2] :
        (S == 2'b11) ? W[3] : 1'bx;
endmodule

