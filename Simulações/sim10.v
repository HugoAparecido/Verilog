


module top (
  input [15:0] W,
  output [3:0] Y,
  output Z); 
  
  //Instancie aqui os componentes disponiveis para formar um codificador de 16x4

  mux8to2 mux_p1(.W(W[0:7]), .S(Y[0:1]), .Z(Z));
  mux8to2 mux_p2(.W(W[7:15]), .S(Y[2:3]), .Z(Z));

endmodule