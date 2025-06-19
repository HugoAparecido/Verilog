module top (
    input [31:0] in, 
    input [1:0] sel, 
    output [7:0] out);

    //declare os fios intermediarios 
    wire [7:0] cadeia0 = in [7:0];
    wire [7:0] cadeia1 = in [15:8];
    wire [7:0] cadeia2 = in [23:16];
    wire [7:0] cadeia3 = in [31:24];
    wire [7:0] mux0;
    wire [7:0] mux1;

    // instancie os muxes que precisar 
    mux2byte mux0_ins (cadeia0, cadeia1, sel[0], mux0);
    mux2byte mux1_ins (cadeia2, cadeia3, sel[0], mux1);

    mux2byte mux2_ins (mux0, mux1, sel[1], out);

endmodule