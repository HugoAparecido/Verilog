module top (
  input clk, rst,
  output [31:0] fibonacci_bus);
  // gere o controle do barramento aqui

  tri [31:0] internal_fibonacci_bus;
  assign fibonacci_bus = internal_fibonacci_bus;
  
  wire enable_send_A;
  wire enable_receive_A;
  wire enable_send_B;
  wire enable_receive_B;

  controle_fibonacci u_controle (
    .clk(clk),
    .rst(rst),
    .enable_send_A(enable_send_A),
    .enable_receive_A(enable_receive_A),
    .enable_send_B(enable_send_B),
    .enable_receive_B(enable_receive_B)
  );

  // instancie os dois módulos fibo aqui
 fibo a (
    .clk            (clk),
    .rst            (rst),
    .enable_send    (enable_send_A),
    .enable_receive (enable_receive_A),
    .bus            (internal_fibonacci_bus)
    );

fibo b (
    .clk            (clk),
    .rst            (rst),
    .enable_send    (enable_send_B),
    .enable_receive (enable_receive_B),
    .bus            (internal_fibonacci_bus)
    );
endmodule

module fibo (
  input clk, rst, enable_send, enable_receive, 
  inout tri [31:0] bus);
  integer value;
  // implemente a lógica do módulo fibo aqui

  wire [31:0] tristate_out_data;

  assign bus = enable_send ? value : 32'bz;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
        value = 0;
    end else if (enable_receive) begin
        value = value + bus;
    end
  end

endmodule

module buffer_tristate (
    input enable,
    input [31:0] data_in,
    output [31:0] data_out
);

  assign data_out = enable ? data_in : 32'bz;
    
endmodule

module controle_fibonacci (
    input clk,
    input rst,
    output reg enable_send_A,
    output reg enable_receive_A,
    output reg enable_send_B,
    output reg enable_receive_B,
);

    parameter S_INIT = 2'b00;
    parameter S_A_SEND = 2'b01;
    parameter S_B_SEND = 2'b10;

    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S_INIT;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        enable_send_A = 1'b0;
        enable_receive_A = 1'b0;
        enable_send_B = 1'b0;
        enable_receive_B = 1'b0;

        next_state = current_state;

        case (current_state)
            S_INIT: begin
                next_state = S_B_SEND;
            end 

            S_A_SEND: begin
                enable_send_A = 1'b1;
                enable_receive_B = 1'b1;
                next_state = S_B_SEND;
            end

            S_B_SEND: begin
                enable_send_B = 1'b1;
                enable_receive_A = 1'b1;
                next_state = S_A_SEND;
            end

            default: begin
                next_state = S_INIT;
            end
        endcase
    end
    
endmodule