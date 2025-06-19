module top (input mtpx, input mtpy, output mtpz);
    // use os fios a seguir de acordo com a figura
    wire a1, b1, a2, b2, a1b1, a2b2;
    // Implemente a primeira parte do circuito usando os módulos ma e mb
    // Preste atenção nas portas desconectadas 
    ma ia1(.mapz(a1), .mapx(mtpx));
    mb ib1(mtpx, mtpy, b1);
    ma ia2(mtpx, mtpy, a2);
    mb ib2(.mbpz(b2), .mbpy(mtpy));

    // Implemente a segunda parte do circuito usando primitivas da linguagem
    
    or (a1b1, a1, b1);
    and (a2b2, a2, b2);
    xor (mtpz, a1b1, a2b2);
    
endmodule