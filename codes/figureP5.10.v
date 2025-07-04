module lfsr (R, L, Clock, Q);
	input [0:2] R;
	input L, Clock;
	output reg [0:2] Q;

	always @(posedge Clock)
		if (L)
			Q <= R;
		else
			Q <= {Q[2], Q[0], Q[1] ^ Q[2]};

endmodule
