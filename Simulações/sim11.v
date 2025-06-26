module top(
    input  CLOCK_27, // 27 MHz clock input
    output [5:0] LEDO, // Orange LEDs
    output [7:0] LEDG); // Green LEDs

    parameter frequency = 27_000_000; // Crystal oscillator frequency is 27Mhz
    parameter limit = frequency/2-1; // 0.5 seconds at 27MHz

    reg clk1hz = 1'b0; 
    integer counter = 0;
    always @(posedge CLOCK_27)
        if (counter < limit)
            counter <= counter + 1;
        else begin
            counter <= 0;
            clk1hz <= ~clk1hz; // Toggle clk1hz every 0.5 seconds
        end

    reg blink = 1'b0;
    always @(posedge clk1hz)
        blink <= ~blink;

    // assign LEDO = {6{blink}}; 
    assign LEDO = {{3{blink}}, {3{~blink}}}; 
    // assign LEDO = {3{blink,~blink}}; 

    reg [7:0] johnson = 8'b00000000;
    always @(posedge clk1hz)
        johnson <= {johnson, ~johnson[7]};
    assign LEDG = johnson;
endmodule