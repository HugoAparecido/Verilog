module top (
  input [15:0] W,
  output [3:0] Y,
  output Z); 
  
  //Instancie aqui os componentes disponiveis para formar um codificador de 16x4

  priority_encoder enc0 (
    .W(W[15:12]), 
    .Y(Y[3:2]), 
    .Z(Z)
  );

  priority_encoder enc1 (
    .W({W[13:12], Y[3:2]}), 
    .Y(Y[3:2]), 
    .Z(Z)
  );


endmodule