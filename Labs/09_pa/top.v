/* Bancada:
844917 Hugo Aparecido
846975 Eduard Kobayashi

1. Com que frequência este contator conta?
R: Aproximadamente 1Hertz

2. Com que frequência os digitos se alternam no display?
R: Aproximadamente 3.9 Mhertz
 
*/

module top(
    input sysclk, // 125MHz
    input [3:0] SW, 
    output [6:0] HEX0,
    output [3:0] jb, jc); 

    wire [6:0] segs;
    wire [3:0] val;
    wire cat;
    integer count = 0; // 32 bits  
    always@(posedge sysclk)
        count = count + 1;
    //assign clk1hz = count[26]; //≅1Hz https://www.google.com/search?q=125Mhz%2F2^27 
    //power_on_reset por(sysclk, rst);

    dec7seg dig(val, segs);
 
    assign val = count[5] ? count[31:28] : count[27:24];
    assign cat = count[5]; 
    assign {jc,jb} = {cat,segs};

    wire [3:0] F;
    wire [3:0] vezes;
    wire [3:0] sub;

    alu alu_sub(2, count[5], 'b0001, sub);
    assign vezes = sub * SW[3:0];
    alu alu_pa(3, vezes, 'b0000, F);

    dec7seg pa_dis(F, segs);

    assign HEX0 = ~segs;

endmodule