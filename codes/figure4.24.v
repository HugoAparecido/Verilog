module mux2to1 (w0, w1, s, f);
	input w0, w1, s;
	output reg f;
		
	always @(w0, w1, s)
		f = s ? w1 : w0;
endmodule

