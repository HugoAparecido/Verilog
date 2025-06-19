module top (
    input  [31:0] a,
    input  [31:0] b,
    input         sub,         // 0 = soma, 1 = subtração
    output [31:0] result,
    output        carry_out,
    output        overflow);

    wire [32:0] carry;

    wire [31:0] b_in;
    wire initial_carry;

    assign b_in = sub ? ~b : b;
    assign initial_carry = sub ? 1'b1 : 1'b0;

    assign carry[0] = initial_carry;

    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : fa_gen
            full_adder fa_inst (
                .a(a[i]),
                .b(b_in[i]),
                .cin(carry[i]),
                .s(result[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign carry_out = carry[32];

    assign overflow = carry[31] ^ carry[32];

endmodule