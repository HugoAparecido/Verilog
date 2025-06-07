module full_adder (
    input  a, b, cin,
    output s, cout);
    assign s = a ^ b ^ cin; // Sum output
    assign cout = (a & b) | (cin & (a ^ b)); // Carry output
endmodule

// top_add_sub.v
module top (
    input  [31:0] a,
    input  [31:0] b,
    input         sub,         // 0 = soma, 1 = subtração
    output [31:0] result,
    output        carry_out,
    output        overflow
);

    // Wires para os carries intermediários
    // carries[0] será o carry-in para o full_adder[0]
    // carries[32] será o carry-out final do full_adder[31]
    wire [32:0] carries;

    // Wires para o operando B modificado (B_in) e o carry-in inicial (initial_carry)
    wire [31:0] B_in;
    wire        initial_carry;

    // Lógica para soma/subtração:
    // Se sub é 0 (soma): B_in = B, initial_carry = 0
    // Se sub é 1 (subtração): B_in = ~B (complemento de um), initial_carry = 1
    assign B_in = sub ? ~b : b;
    assign initial_carry = sub ? 1'b1 : 1'b0;

    // Conecta o carry-in inicial ao primeiro estágio do somador
    assign carries[0] = initial_carry;

    // Instanciação dos 32 full adders para formar o somador/subtrator
    genvar i; // Declaração de variável para o loop generate
    generate
        for (i = 0; i < 32; i = i + 1) begin : fa_gen // 'fa_gen' é um nome para o bloco generate
            full_adder fa_inst (
                .a   (a[i]),         // Bit 'i' do operando A
                .b   (B_in[i]),      // Bit 'i' do operando B (ou ~B)
                .cin (carries[i]),   // Carry-in do estágio anterior
                .s   (result[i]),    // Bit 'i' da soma/diferença
                .cout(carries[i+1])  // Carry-out para o próximo estágio
            );
        end
    endgenerate

    // A carry_out final é o carry-out do último estágio (MSB)
    assign carry_out = carries[32];

    // Lógica para detecção de Overflow em complemento de dois
    // Overflow ocorre se: (carry-in do MSB != carry-out do MSB)
    // carry-in do MSB é carries[31]
    // carry-out do MSB é carries[32]
    assign overflow = carries[31] ^ carries[32];

endmodule