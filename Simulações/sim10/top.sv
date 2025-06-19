module top (
  input [15:0] W,
  output [3:0] Y,
  output Z); 
  
  //Instancie aqui os componentes disponiveis para formar um codificador de 16x4

  wire [1:0] Y_enc0, Y_enc1, Y_enc2, Y_enc3;
  wire Z_enc0, Z_enc1, Z_enc2, Z_enc3;

  wire [1:0] S_mux;

  // Instanciação dos quatro codificadores de 4 bits
  // W[3:0] - baixa prioridade (enc0)
  priority_encoder enc0 (
    .W(W[3:0]), 
    .Y(Y_enc0), 
    .Z(Z_enc0)
  );

  // W[7:4] - enc1
  priority_encoder enc1 (
    .W(W[7:4]), 
    .Y(Y_enc1), 
    .Z(Z_enc1)
  );

  // W[11:8] - enc2
  priority_encoder enc2 (
    .W(W[11:8]), 
    .Y(Y_enc2), 
    .Z(Z_enc2)
  );

  // W[15:12] - alta prioridade (enc3)
  priority_encoder enc3 (
    .W(W[15:12]), 
    .Y(Y_enc3), 
    .Z(Z_enc3)
    );

  assign S_mux = (Z_enc3) ? 2'b11 : // Se houver '1' em W[15:12]
                (Z_enc2) ? 2'b10 : // Senão, se houver '1' em W[11:8]
                (Z_enc1) ? 2'b01 : // Senão, se houver '1' em W[7:4]
                (Z_enc0) ? 2'b00 : // Senão, se houver '1' em W[3:0]
                2'bxx;             // Default se nenhum '1' for encontrado

  mux8to2 main_mux (
        .W({Y_enc3, Y_enc2, Y_enc1, Y_enc0}), // Concatena as 4 saídas de 2 bits
        .S(S_mux),                            // Seleciona com base na prioridade do grupo
        .f(Y[1:0])                            // A saída do mux é a parte LSB de Y
  );

  assign Y[3:2] = S_mux;

  assign Z = Z_enc0 | Z_enc1 | Z_enc2 | Z_enc3;

endmodule