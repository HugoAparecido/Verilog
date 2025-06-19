module top (
  input [15:0] W,
  output [3:0] Y,
  output Z); 
  
  //Instancie aqui os componentes disponiveis para formar um codificador de 16x4

  // Instanciação dos quatro codificadores de 4 bits
  // W[3:0] - baixa prioridade (enc0)
  priority_encoder enc0 (
    .W(W[3:0]), 
    .Y(Y_enc0), 
    .Z(Z)
  );

  // W[7:4] - enc1
  priority_encoder enc1 (
    .W(W[7:4]), 
    .Y(Y_enc1), 
    .Z(Z)
  );

  // W[11:8] - enc2
  priority_encoder enc2 (
    .W(W[11:8]), 
    .Y(Y_enc2), 
    .Z(Z)
  );

  // W[15:12] - alta prioridade (enc3)
  priority_encoder enc3 (
    .W(W[15:12]), 
    .Y(Y_enc3), 
    .Z(Z)
    );

  mux8to2 main_mux (
        .W({Y_enc3, Y_enc2, Y_enc1, Y_enc0}), // Concatena as 4 saídas de 2 bits
        .S(Y[3:2]),                            // Seleciona com base na prioridade do grupo
        .f(Y[1:0])                            // A saída do mux é a parte LSB de Y
  );

endmodule