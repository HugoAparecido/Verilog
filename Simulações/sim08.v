module top (
    input a, b, c, d,
    output f1, f2, f3);

    assign f1 = ~c&~d | a&b&d | ~a&~b&c&d;    
    assign f2 = (b|c|d) & (~b|~d) & (a|~c);
    assign f3 = a&~c | ~b&~c&~d | b&c&d | ~a&~b&c;

endmodule