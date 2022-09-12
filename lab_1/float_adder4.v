`include "barrel_shifter_32bit.v"
`include "barrel_shifter_32bit_right.v"
`include "four_bit_adder.v"
`include "five_bit_adder.v"
`include "eleven_bit_adder.v"

module float_adder(A, B, sign, C, overflow, underflow);

    input [16:1] A, B;
    input sign;
    output [16:1] C;
    output wire overflow, underflow;
    
    wire Asign, Bsign, less, lsign, gsign, c, carry, car, car1, car2, car3, car4, car5, s1, s2, comp, final_sign, lmark;
    wire [10:1] Amant, Bmant, mant_of_small_exp, mant_of_big_exp, lmant, gmant, final_mant;
    wire [5:1] Aexp, Bexp, lexp, gexp, exp_2s, fin_exp, fin_exp1, final_exp, shift1, sh1, diff;
    wire [11:1] bslmo, new_lmant, new_gmant, op1, op2, mant_op, m, m1, operator1, operator2, fin_mant;
    wire [4:1] shift; 
    
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
    assign lmark=less?0:1;              //a:0, b:1
    assign exp_2s=-lexp;                //find the 2's complement of the lesser exp so that we can find the difference
    five_bit_adder FBA (exp_2s, gexp, 1'b0, diff, c);      //find the diff between the exponents 
    
    assign new_lmant[11]=1'b1;          //padding the whole number 1
    assign new_lmant[10:1]=lmant;
    assign new_gmant[11]=1'b1;
    assign new_gmant[10:1]=gmant;
    
    barrelShifterRight BSR (new_lmant, diff, bslmo);    //bslmo-barrel shifter mantissa corresponding to lower mantissa output
    
    assign op1=!lmark?bslmo:new_gmant;
    assign op2=!lmark?new_gmant:bslmo;
    
    wire negative_check;
    wire s1_temp, s2_temp;

    assign s1_temp=!lmark?lsign:gsign;
    assign s2_temp=!lmark?sign^gsign:sign^lsign;
    
    assign negative_check = s1_temp&s2_temp;
    assign s1 = negative_check&1'b0 | ~negative_check&s1_temp;
    assign s2 = negative_check&1'b0 | ~negative_check&s2_temp;

    assign comp=(op1<op2);
    
    wire final_sign_temp;
    assign final_sign_temp=comp?s2:s1;
    assign final_sign = (negative_check&1'b1) | ((~negative_check)&final_sign_temp);
    assign operator1=!s1?op1:-op1;
    assign operator2=!s2?op2:-op2;
    
    eleven_bit_adder EBA (operator1, operator2, 1'b0, mant_op, carry);
    
    assign m=(final_sign)?-mant_op:mant_op;
    
    wire [5:1] shift_count;
    assign shift_count[5:2] = 4'b0000;
    assign shift_count[1] = carry&~s1&~s2;

    five_bit_adder FBA1 (gexp, shift_count, 1'b0, fin_exp, car); 
    
    wire [11:1] result_mat;
    barrelShifterRight BRSS (mant_op, shift_count, result_mat);
    wire [11:1] result_matissa;

    assign result_matissa[10:1] = result_mat[10:1];
    assign result_matissa[11] = carry&~s1&~s2;
    
    assign shift1=result_matissa[11]?5'b00000: result_matissa[10]?5'b00001: result_matissa[9]?5'b00010: result_matissa[8]?5'b00011: result_matissa[7]?5'b00100: result_matissa[6]?5'b00101: result_matissa[5]?5'b00110: result_matissa[4]?5'b00111: result_matissa[3]?5'b01000: result_matissa[2]?5'b01001: result_matissa[1]?5'b01010: gexp;
    
    five_bit_adder FB3 (fin_exp, -shift1, 1'b0, fin_exp1, car2);
    
	// remove the below line 
    // five_bit_adder FB4 (shift1, carry, 1'b0, sh1, car3);
    
    barrelShifter BS2 ( result_matissa, shift1, fin_mant);
    
    wire a1, b1;
    assign a1=A[1]|A[2]|A[3]|A[4]|A[5]|A[6]|A[7]|A[8]|A[9]|A[10]|A[11]|A[12]|A[13]|A[14]|A[15];
    assign b1=B[1]|B[2]|B[3]|B[4]|B[5]|B[6]|B[7]|B[8]|B[9]|B[10]|B[11]|B[12]|B[13]|B[14]|B[15];

    wire ab;
    assign ab=a1&b1;

    assign final_exp=ab?fin_exp1:!a1?Bexp:Aexp;
    assign final_mant=ab?fin_mant:!a1?Bmant:Amant;
    assign overflow = (~(|Amant))&(&Aexp) | (~(|Bmant))&(&Bexp) ;
    assign underflow= car2&(~overflow) ;

    assign C[16]=final_sign;
    assign C[15:11]=final_exp;
    assign C[10:1]=final_mant;
 
endmodule

