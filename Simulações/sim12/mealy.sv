module mealy (
    input clk, rst, w, 
    output reg z);


    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] estado_atual;
    reg [1:0] proximo_estado;

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            estado_atual <= S0;
        end else begin
            estado_atual <= proximo_estado;
        end
    end

    always @(*) begin
        proximo_estado = estado_atual;
        z = 1'b0;
        case (estado_atual)
            S0: begin
                if (w == 1'b1)
                    proximo_estado = S1;
                else
                    proximo_estado = S0;
            end
            S1: begin
                if (w == 1'b0)
                    proximo_estado = S2;
                else
                    proximo_estado = S1;
            end
            S2: begin
                if (w == 1'b0)
                    proximo_estado = S3;
                else
                    proximo_estado = S1;
            end
            S3: begin
                if (w == 1'b1) begin
                    proximo_estado = S1;
                    z = 1'b1;
                end
                else begin
                    proximo_estado = S0;
                    z = 1'b0;
                end
            end
            default: begin 
                proximo_estado = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule