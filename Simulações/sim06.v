module top (
    input x, y, z, 
    output f);
    assign f = ~x ? ~y & z : ~y | y&z ;
endmodule