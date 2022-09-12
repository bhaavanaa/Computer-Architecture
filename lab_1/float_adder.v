`include "barrel_shifter_32bit_right.v"
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
    wire c, carry;
    wire [11:1] bslmo;
    wire [11:1] new_lmant, new_gmant;
    wire s1, s2;
    wire [11:1] op1, op2;
    wire [11:1] mant_op;
    wire comp, final_sign;
    wire [11:1] m;
    
    assign A=16'b0100010000000000;
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
    assign exp_2s=-lexp;                //find the 2's complement of the lesser exp so that we can find the difference
    five_bit_adder FBA (exp_2s, gexp, 0, diff, c);      //find the diff between the exponents 
    
    assign new_lmant[11]=1'b1;          //padding the whole number 1
    assign new_lmant[10:1]=lmant;
    assign new_gmant[11]=1'b1;
    assign new_gmant[10:1]=gmant;
    
    barrelShifterRight BSR (new_lmant, diff, bslmo);    //bslmo-barrel shifter mantissa corresponding to lower mantissa output
    
    initial
    $monitor("%b %b", bslmo, new_gmant);
    
    assign comp=(bslmo<new_gmant);      //if lower-greater=-ve i.e lower<greater then ans=1
    assign final_sign=comp?gsign:lsign;
    
    assign s1=lsign;
    assign s2=gsign^sign;
    
    assign op1=s1?-bslmo:bslmo;
    assign op2=s2?-new_gmant:new_gmant;
    
    eleven_bit_adder EBA (op1, op2, 1'b0, mant_op, carry);
    
    assign m=final_sign?-mant_op: mant_op;      //stores the final mantissa without the final shift operation   
    
    initial
    $monitor("%b, %b %b", final_sign, m, carry);
       
        
endmodule
