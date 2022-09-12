module mux_2to1(In1, In2, select, Out);
    input In1, In2, select;
    output Out;
    
    assign Out=(!select&In1) | (select&In2);
    
endmodule
