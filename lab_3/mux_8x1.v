module mux_8x1(i0, i1, i2, i3, i4, i5, i6, i7, op, out);
    input i0, i1, i2, i3, i4, i5, i6, i7;
    input [3:1] op;
    output out;
    
    assign out=i0&!op[1]&!op[2]&!op[3] | i1&op[1]&!op[2]&!op[3] | i2&!op[1]&op[2]&!op[3] | i3&op[1]&op[2]&!op[3] | i4&!op[1]&!op[2]&op[3] | i5&op[1]&!op[2]&op[3] | i6&!op[1]&op[2]&op[3] | i7&op[1]&op[2]&op[3];

endmodule
