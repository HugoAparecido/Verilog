module comparator (X, Y, V, N, Z); // figure3.47.v
	parameter n = 32;
	input [n-1:0] X, Y; 
	output V, N, Z; 
	wire [n-1:0] S; 
	wire [n:0] C;

    wire [n-1:0] Y_comp;

	assign C[0] = 1'b1;

    genvar k;
	generate
		for (k = 0; k < n;  k = k + 1)
		begin
            // assign Y_comp[k] = ~Y[k];
			assign S[k] = X[k] ^ ~Y[k] ^ C[k];
			assign C[k+1] = (X[k] & ~Y[k]) | (X[k] & C[k]) | (~Y[k] & C[k]);
		end
    endgenerate
    
	assign V  = C[n] ^ C[n-1]; 
	assign N = S[n-1]; 
	assign Z = (S == {n{1'b0}});

endmodule
