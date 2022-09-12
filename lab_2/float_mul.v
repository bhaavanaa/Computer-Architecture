`include "five_bit_adder.v"
`include "six_bit_adder.v"
`include "wallace16b.v"

module float_mul(A, B, result, overflow);

    input [16:1] A, B;
    output [16:1] result;
    output overflow;
    
    wire Asign, Bsign;
    wire [5:1] Aexp, Bexp;
    wire [10:1] Amant, Bmant;
    wire [11:1] Amant1, Bmant1;
    wire [16:1] Amant2, Bmant2;
    wire [32:1] wallace_out;
    wire [5:1] sum, final_exp;
    wire car, final_sign, c, c1, comp, a1, b1, ab, a2, b2, ab2;
    wire [12:1] new_prod;
    wire [10:1] final_mant;
    wire [6:1] new_exp, new_exp1, new_exp12, exp1;
    wire [16:1] result1, res;
    
    assign Asign=A[16];                 //division of IEEE 754 number
    assign Bsign=B[16];
    assign Aexp=A[15:11];
    assign Bexp=B[15:11];
    assign Amant=A[10:1];
    assign Bmant=B[10:1];
    
    assign Amant1[11]=1'b1;             //padding the number with 1
    assign Amant1[10:1]=Amant;
    assign Bmant1[11]=1'b1;
    assign Bmant1[10:1]=Bmant;
    
    assign Amant2[16:12]=4'b0000;       //padding 0000 to the 11bits, so that it can be sent to 16bit wallace
    assign Amant2[11:1]=Amant1;
    assign Bmant2[16:12]=4'b0000;
    assign Bmant2[11:1]=Bmant1;
    
    five_bit_adder FBA (Aexp, Bexp, 1'b0, sum, car);    //addition of the exponents
    
    //initial
    //$monitor("%b %b %b %b", Aexp, Bexp, sum, car);
        
    assign final_sign=A[16]^B[16];      //assign the final sign bit
    
    wallace16b w16b (Amant2, Bmant2, wallace_out);      //multiplying the mantissas
    
    //initial
    //$monitor("%b %b %b", Amant2, Bmant2, wallace_out);
    
    assign new_prod=wallace_out[22:11];
    
    assign final_mant=new_prod[12]?new_prod[11:2]:new_prod[10:1];
    
    assign new_exp[6]=car;
    assign new_exp[5:1]=sum;
    
    six_bit_adder SBA (new_exp, 1'b1, 1'b0, new_exp1, c);
    
    assign exp1=new_prod[12]? new_exp1:new_exp;
    
    six_bit_adder SBA2 (exp1, -6'b001111, 1'b0, new_exp12, c1);
    
    assign final_exp=new_exp12[5:1];
    
    assign result1[16]=final_sign;
    assign result1[15:11]=final_exp;
    assign result1[10:1]=final_mant;
    
    assign overflow=new_exp12[6]?1'b1:1'b0;
    
    assign a1=A[1]|A[2]|A[3]|A[4]|A[5]|A[6]|A[7]|A[8]|A[9]|A[10]|A[11]|A[12]|A[13]|A[14]|A[15];
    assign b1=B[1]|B[2]|B[3]|B[4]|B[5]|B[6]|B[7]|B[8]|B[9]|B[10]|B[11]|B[12]|B[13]|B[14]|B[15];
    assign ab=a1&b1;
    
    assign a2=A[1]|A[2]|A[3]|A[4]|A[5]|A[6]|A[7]|A[8]|A[9]|A[10]|!A[11]|!A[12]|!A[13]|!A[14]|!A[15];
    assign b2=B[1]|B[2]|B[3]|B[4]|B[5]|B[6]|B[7]|B[8]|B[9]|B[10]|!B[11]|!B[12]|!B[13]|!B[14]|!B[15];
    assign ab2=a2&b2;
    assign res[16]=final_sign;
    assign res[15:11]=5'b11111;
    assign res[10:1]=10'b0;
    
    assign result=!ab?16'b0:!ab2?res:result1;
    
    //initial
    //$monitor("%b %b %b %b", final_sign, final_exp, final_mant, overflow);
    
endmodule
