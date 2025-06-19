module top (
  input [15:0] W,
  output [3:0] Y,
  output Z); 
  
  //Instancie aqui os componentes disponiveis para formar um codificador de 16x4

  priority_encoder enc0 (
    .W(W[3:0]), 
    .Y(Y[3:2]), 
    .Z(Z)
  );

  mux8to2 main_mux (
    .W(),
    .S(),
    .f(Y[1:0])
  );

endmodule