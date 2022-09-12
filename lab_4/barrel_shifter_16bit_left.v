`include "mux_2to1_1.v"

module barrelShifterLeft( Ip, shift_mag, Op);        
    
    input [15:0] Ip;
    input [3:0] shift_mag; 
    output [15:0] Op;  
    wire [15:0] ST1, ST2, ST3, ST4;

    mux_2to1_1 m0 (1'b0, Ip[0], shift_mag[0], ST1[0]); 
    mux_2to1_1 m1 (Ip[0], Ip[1], shift_mag[0], ST1[1]);
    mux_2to1_1 m2 (Ip[1], Ip[2], shift_mag[0], ST1[2]);
    mux_2to1_1 m3 (Ip[2], Ip[3], shift_mag[0], ST1[3]);
    mux_2to1_1 m4 (Ip[3], Ip[4], shift_mag[0], ST1[4]);
    mux_2to1_1 m5 (Ip[4], Ip[5], shift_mag[0], ST1[5]);
    mux_2to1_1 m6 (Ip[5], Ip[6], shift_mag[0], ST1[6]);
    mux_2to1_1 m7 (Ip[6], Ip[7], shift_mag[0], ST1[7]);
    mux_2to1_1 m8 (Ip[7], Ip[8], shift_mag[0], ST1[8]);
    mux_2to1_1 m9 (Ip[8], Ip[9], shift_mag[0], ST1[9]);
    mux_2to1_1 m10 (Ip[9], Ip[10], shift_mag[0], ST1[10]);
    mux_2to1_1 m11111111111 (Ip[10], Ip[11], shift_mag[0], ST1[11]);
    mux_2to1_1 m12 (Ip[11], Ip[12], shift_mag[0], ST1[12]);
    mux_2to1_1 m13 (Ip[12], Ip[13], shift_mag[0], ST1[13]);
    mux_2to1_1 m14 (Ip[13], Ip[14], shift_mag[0], ST1[14]);
    mux_2to1_1 m15 (Ip[14], Ip[15], shift_mag[0], ST1[15]);
    
    mux_2to1_1 m00 (1'b0, ST1[0], shift_mag[1], ST2[0]); 
    mux_2to1_1 m11 (1'b0, ST1[1], shift_mag[1], ST2[1]);
    mux_2to1_1 m22 (ST1[0], ST1[2], shift_mag[1], ST2[2]);
    mux_2to1_1 m33 (ST1[1], ST1[3], shift_mag[1], ST2[3]);
    mux_2to1_1 m44 (ST1[2], ST1[4], shift_mag[1], ST2[4]);
    mux_2to1_1 m55 (ST1[3], ST1[5], shift_mag[1], ST2[5]);
    mux_2to1_1 m66 (ST1[4], ST1[6], shift_mag[1], ST2[6]);
    mux_2to1_1 m77 (ST1[5], ST1[7], shift_mag[1], ST2[7]);
    mux_2to1_1 m88 (ST1[6], ST1[8], shift_mag[1], ST2[8]);
    mux_2to1_1 m99 (ST1[7], ST1[9], shift_mag[1], ST2[9]);
    mux_2to1_1 m1010 (ST1[8], ST1[10], shift_mag[1], ST2[10]);
    mux_2to1_1 m1111 (ST1[9], ST1[11], shift_mag[1], ST2[11]);
    mux_2to1_1 m1212 (ST1[10], ST1[12], shift_mag[1], ST2[12]);
    mux_2to1_1 m1313 (ST1[11], ST1[13], shift_mag[1], ST2[13]);
    mux_2to1_1 m1414 (ST1[12], ST1[14], shift_mag[1], ST2[14]);
    mux_2to1_1 m1515 (ST1[13], ST1[15], shift_mag[1], ST2[15]);
    
    mux_2to1_1 m000 (1'b0, ST2[0], shift_mag[2], ST3[0]);
    mux_2to1_1 m111 (1'b0, ST2[1], shift_mag[2], ST3[1]);
    mux_2to1_1 m222 (1'b0, ST2[2], shift_mag[2], ST3[2]);
    mux_2to1_1 m333 (1'b0, ST2[3], shift_mag[2], ST3[3]);
    mux_2to1_1 m444 (ST2[0], ST2[4], shift_mag[2], ST3[4]);
    mux_2to1_1 m555 (ST2[1], ST2[5], shift_mag[2], ST3[5]);
    mux_2to1_1 m666 (ST2[2], ST2[6], shift_mag[2], ST3[6]);
    mux_2to1_1 m777 (ST2[3], ST2[7], shift_mag[2], ST3[7]);
    mux_2to1_1 m888 (ST2[4], ST2[8], shift_mag[2], ST3[8]);
    mux_2to1_1 m999 (ST2[5], ST2[9], shift_mag[2], ST3[9]);
    mux_2to1_1 m101010 (ST2[6], ST2[10], shift_mag[2], ST3[10]);
    mux_2to1_1 m111111 (ST2[7], ST2[11], shift_mag[2], ST3[11]);
    mux_2to1_1 m121212 (ST2[8], ST2[12], shift_mag[2], ST3[12]);
    mux_2to1_1 m131313 (ST2[9], ST2[13], shift_mag[2], ST3[13]);
    mux_2to1_1 m141414 (ST2[10], ST2[14], shift_mag[2], ST3[14]);
    mux_2to1_1 m151515 (ST2[11], ST2[15], shift_mag[2], ST3[15]);
    
    mux_2to1_1 m0000 (1'b0, ST3[0], shift_mag[3], Op[0]);
    mux_2to1_1 m111111111 (1'b0, ST3[1], shift_mag[3], Op[1]);
    mux_2to1_1 m2222 (1'b0, ST3[2], shift_mag[3], Op[2]);
    mux_2to1_1 m3333 (1'b0, ST3[3], shift_mag[3], Op[3]);
    mux_2to1_1 m4444 (1'b0, ST3[4], shift_mag[3], Op[4]);
    mux_2to1_1 m5555 (1'b0, ST3[5], shift_mag[3], Op[5]);
    mux_2to1_1 m6666 (1'b0, ST3[6], shift_mag[3], Op[6]);
    mux_2to1_1 m7777 (1'b0, ST3[7], shift_mag[3], Op[7]);
    mux_2to1_1 m8888 (ST3[0], ST3[8], shift_mag[3], Op[8]);
    mux_2to1_1 m9999 (ST3[1], ST3[9], shift_mag[3], Op[9]);
    mux_2to1_1 m10101010 (ST3[2], ST3[10], shift_mag[3], Op[10]);
    mux_2to1_1 m11111111 (ST3[3], ST3[11], shift_mag[3], Op[11]);
    mux_2to1_1 m12121212 (ST3[4], ST3[12], shift_mag[3], Op[12]);
    mux_2to1_1 m13131313 (ST3[5], ST3[13], shift_mag[3], Op[13]);
    mux_2to1_1 m14141414 (ST3[6], ST3[14], shift_mag[3], Op[14]);
    mux_2to1_1 m15151515 (ST3[7], ST3[15], shift_mag[3], Op[15]);

endmodule
