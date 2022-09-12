`include "mux_2to1_1.v"

module barrelShifter( Ip, shift_mag, Op);        
    
    input [10:0] Ip;
    input [4:0] shift_mag; 
    output [10:0] Op;  
    wire [10:0] ST1, ST2, ST3, ST4;

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
    
    mux_2to1_1 m0000 (1'b0, ST3[0], shift_mag[3], ST4[0]);
    mux_2to1_1 m1111 (1'b0, ST3[1], shift_mag[3], ST4[1]);
    mux_2to1_1 m2222 (1'b0, ST3[2], shift_mag[3], ST4[2]);
    mux_2to1_1 m3333 (1'b0, ST3[3], shift_mag[3], ST4[3]);
    mux_2to1_1 m4444 (1'b0, ST3[4], shift_mag[3], ST4[4]);
    mux_2to1_1 m5555 (1'b0, ST3[5], shift_mag[3], ST4[5]);
    mux_2to1_1 m6666 (1'b0, ST3[6], shift_mag[3], ST4[6]);
    mux_2to1_1 m7777 (1'b0, ST3[7], shift_mag[3], ST4[7]);
    mux_2to1_1 m8888 (ST3[0], ST3[8], shift_mag[3], ST4[8]);
    mux_2to1_1 m9999 (ST3[1], ST3[9], shift_mag[3], ST4[9]);
    mux_2to1_1 m10101010 (ST3[2], ST3[10], shift_mag[3], ST4[10]);
    
    mux_2to1_1 m00000 (1'b0, ST4[0], shift_mag[4], Op[0]);
    mux_2to1_1 m11111 (1'b0, ST4[1], shift_mag[4], Op[1]);
    mux_2to1_1 m22222 (1'b0, ST4[2], shift_mag[4], Op[2]);
    mux_2to1_1 m33333 (1'b0, ST4[3], shift_mag[4], Op[3]);
    mux_2to1_1 m44444 (1'b0, ST4[4], shift_mag[4], Op[4]);
    mux_2to1_1 m55555 (1'b0, ST4[5], shift_mag[4], Op[5]);
    mux_2to1_1 m66666 (1'b0, ST4[6], shift_mag[4], Op[6]);
    mux_2to1_1 m77777 (1'b0, ST4[7], shift_mag[4], Op[7]);
    mux_2to1_1 m88888 (1'b0, ST4[8], shift_mag[4], Op[8]);
    mux_2to1_1 m99999 (1'b0, ST4[9], shift_mag[4], Op[9]);
    mux_2to1_1 m1010101010 (1'b0, ST4[10], shift_mag[4], Op[10]);

endmodule
