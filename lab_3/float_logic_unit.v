`include "mux_8x1.v"

module float_logic_unit(A, B, op, out);
    input [16:1] A, B;
    input [3:1] op;
    output [16:1] out;
    
    wire [16:1] and_out, nand_out, nor_out, or_out, not_out, xor_out, xnor_out, neg_out;
    
    assign and_out=A & B;               //performs bitwise operations between A and B
    assign nand_out=A ~& B;
    assign nor_out=A ~| B;
    assign or_out=A | B;
    assign not_out=~A;
    assign xor_out=A ^ B;
    assign xnor_out=A ~^ B;
    assign neg_out=~A;
    //assign neg_out[15:1]=A[15:1];
    
    mux_8x1 m1 (and_out[1], nand_out[1], nor_out[1], or_out[1], not_out[1], xor_out[1], xnor_out[1], neg_out[1], op, out[1]);
    mux_8x1 m2 (and_out[2], nand_out[2], nor_out[2], or_out[2], not_out[2], xor_out[2], xnor_out[2], neg_out[2], op, out[2]);
    mux_8x1 m3 (and_out[3], nand_out[3], nor_out[3], or_out[3], not_out[3], xor_out[3], xnor_out[3], neg_out[3], op, out[3]);
    mux_8x1 m4 (and_out[4], nand_out[4], nor_out[4], or_out[4], not_out[4], xor_out[4], xnor_out[4], neg_out[4], op, out[4]);
    mux_8x1 m5 (and_out[5], nand_out[5], nor_out[5], or_out[5], not_out[5], xor_out[5], xnor_out[5], neg_out[5], op, out[5]);
    mux_8x1 m6 (and_out[6], nand_out[6], nor_out[6], or_out[6], not_out[6], xor_out[6], xnor_out[6], neg_out[6], op, out[6]);
    mux_8x1 m7 (and_out[7], nand_out[7], nor_out[7], or_out[7], not_out[7], xor_out[7], xnor_out[7], neg_out[7], op, out[7]);
    mux_8x1 m8 (and_out[8], nand_out[8], nor_out[8], or_out[8], not_out[8], xor_out[8], xnor_out[8], neg_out[8], op, out[8]);
    mux_8x1 m9 (and_out[9], nand_out[9], nor_out[9], or_out[9], not_out[9], xor_out[9], xnor_out[9], neg_out[9], op, out[9]);
    mux_8x1 m10 (and_out[10], nand_out[10], nor_out[10], or_out[10], not_out[10], xor_out[10], xnor_out[10], neg_out[10], op, out[10]);
    mux_8x1 m11 (and_out[11], nand_out[11], nor_out[11], or_out[11], not_out[11], xor_out[11], xnor_out[11], neg_out[11], op, out[11]);
    mux_8x1 m12 (and_out[12], nand_out[12], nor_out[12], or_out[12], not_out[12], xor_out[12], xnor_out[12], neg_out[12], op, out[12]);
    mux_8x1 m13 (and_out[13], nand_out[13], nor_out[13], or_out[13], not_out[13], xor_out[13], xnor_out[13], neg_out[13], op, out[13]);
    mux_8x1 m14 (and_out[14], nand_out[14], nor_out[14], or_out[14], not_out[14], xor_out[14], xnor_out[14], neg_out[14], op, out[14]);
    mux_8x1 m15 (and_out[15], nand_out[15], nor_out[15], or_out[15], not_out[15], xor_out[15], xnor_out[15], neg_out[15], op, out[15]);
    mux_8x1 m16 (and_out[16], nand_out[16], nor_out[16], or_out[16], not_out[16], xor_out[16], xnor_out[16], neg_out[16], op, out[16]);

    //initial
    //$monitor("%b %b %b %b", A, B, op, out);

endmodule
