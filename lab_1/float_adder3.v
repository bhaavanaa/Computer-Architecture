`include "barrel_shifter_32bit_right.v"
`include "barrel_shifter_32bit.v"
`include "four_bit_adder.v"
`include "five_bit_adder.v"
`include "eleven_bit_adder.v"

module float_adder(A, B, sign, C);

    input [16:1] A, B;
    input sign;
    output [16:1] C;
    
    wire Asign, Bsign;
    wire [10:1] Amant, Bmant;
    wire [5:1] Aexp, Bexp;
    wire less;
    wire [5:1] lexp, gexp;
    wire [10:1] mant_of_small_exp, mant_of_big_exp;
    wire [5:1] diff;
    wire [5:1] exp_2s;
    wire [10:1] lmant, gmant;
    wire lsign, gsign;
    wire c, carry, car, car1, car2, car3, car4, car5;
    wire [11:1] bslmo;
    wire [11:1] new_lmant, new_gmant;
    wire s1, s2;
    wire [11:1] op1, op2;
    wire [11:1] mant_op;
    wire comp, final_sign;
    wire [11:1] m, m1;
    wire lmark;
    wire [11:1] operator1, operator2;
    wire [5:1] fin_exp, fin_exp1, final_exp;
    wire [10:1] final_mant;
    wire [11:1] fin_mant;
    wire [4:1] shift;
    wire [5:1] shift1, sh1;
    
    assign A=16'b0100100000000000;
    assign B=16'b0100010100000000;
    assign sign=1;
    
    assign Asign=A[16];                 //Division of IEEE 754 number
    assign Bsign=B[16];
    assign Aexp=A[15:11];
    assign Bexp=B[15:11];
    assign Amant=A[10:1];
    assign Bmant=B[10:1]; 
    
    assign less=(Aexp<Bexp);            //Find the greater exponent, this fn return 0(false) or 1(true)
    assign lexp=less?Aexp:Bexp;         //assigns lesser exp to lexp
    assign gexp=!less?Aexp:Bexp;        //assign the greater exp to gexp
    assign lmant=less?Amant:Bmant;      //assigns lesser exp's mant to lmant
    assign gmant=!less?Amant:Bmant;     //assigns greater exp's mant to gmant
    assign lsign=less?Asign:Bsign;      //assigns lesser exp's sign to lsign
    assign gsign=!less?Asign:Bsign;     //assigns greater exp's sign to gsign
    assign lmark=less?0:1;              
    assign exp_2s=-lexp;                //find the 2's complement of the lesser exp so that we can find the difference
    five_bit_adder FBA (exp_2s, gexp, 0, diff, c);      //find the diff between the exponents 
    
    assign new_lmant[11]=1'b1;          //padding the whole number 1
    assign new_lmant[10:1]=lmant;
    assign new_gmant[11]=1'b1;
    assign new_gmant[10:1]=gmant;
    
    barrelShifterRight BSR (new_lmant, diff, bslmo);    //bslmo-barrel shifter mantissa corresponding to lower mantissa output
    
    assign op1=!lmark?bslmo:new_gmant;
    assign op2=!lmark?new_gmant:bslmo;
    assign s1=!lmark?lsign:gsign;
    assign s2=!lmark?sign^gsign:sign^lsign;
    
    assign comp=(op1<op2);
    
    assign final_sign=comp?s2:s1;
    assign operator1=!s1?op1:-op1;
    assign operator2=!s2?op2:-op2;
    
    eleven_bit_adder EBA (operator1, operator2, 1'b0, mant_op, carry);
    
    assign m=final_sign?-mant_op:mant_op;
    
    five_bit_adder FBA1 (gexp, 1'b1, 1'b0, fin_exp, car);
    
    assign shift=m[11]?4'b0000: m[10]?4'b0001: m[9]?4'b0010: m[8]?4'b0011: m[7]?4'b0100: m[6]?4'b0101: m[5]?4'b0110: m[4]?4'b0111: m[3]?4'b1000: m[2]?4'b1001: m[1]?4'b1010: 4'b1011;
    
    assign shift1[5]=0;
    assign shift1[4:1]=shift;
    five_bit_adder FB3 (gexp, -shift1, 1'b0, fin_exp1, car2);
    
    five_bit_adder FB4 (shift1, 1'b1, 1'b0, sh1, car3);
    barrelShifter BS2 ( m, sh1, fin_mant);
    
    assign final_mant=carry?m[11:2]:fin_mant[11:2];
    assign final_exp=carry?fin_exp:fin_exp1;
    
    initial
    $monitor("%b %b %b", final_sign, final_exp, final_mant);
       
        
endmodule
