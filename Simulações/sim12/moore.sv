module moore (
    input clk, rst, w, 
    output reg z);

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] estado_atual;
    reg [2:0] proximo_estado;

    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            estado_atual <= S0;
        end else begin
            estado_atual <= proximo_estado;
        end
    end

    always @(*) begin
        proximo_estado = estado_atual;
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
                if (w == 1'b1)
                    proximo_estado = S4;
                else
                    proximo_estado = S0;
            end
            S4: begin
                if (w == 1'b1)
                    proximo_estado = S1;
                else
                    proximo_estado = S2;
            end
            default: proximo_estado = S0;
        endcase
    end

    always @(*) begin
        if (estado_atual == S4)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule