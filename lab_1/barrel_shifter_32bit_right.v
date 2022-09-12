`include "mux_2to1.v"

module barrelShifterRight( Ip, shift_mag, Op);        
    
    input [10:0] Ip;
    input [4:0] shift_mag; 
    output [10:0] Op;  
    wire [10:0] ST1, ST2, ST3, ST4;
 
    mux_2to1 m0 (Ip[0], Ip[1], shift_mag[0], ST1[0]);
    mux_2to1 m1 (Ip[1], Ip[2], shift_mag[0], ST1[1]);
    mux_2to1 m2 (Ip[2], Ip[3], shift_mag[0], ST1[2]);
    mux_2to1 m3 (Ip[3], Ip[4], shift_mag[0], ST1[3]);
    mux_2to1 m4 (Ip[4], Ip[5], shift_mag[0], ST1[4]);
    mux_2to1 m5 (Ip[5], Ip[6], shift_mag[0], ST1[5]);
    mux_2to1 m6 (Ip[6], Ip[7], shift_mag[0], ST1[6]);
    mux_2to1 m7 (Ip[7], Ip[8], shift_mag[0], ST1[7]);
    mux_2to1 m8 (Ip[8], Ip[9], shift_mag[0], ST1[8]);
    mux_2to1 m9 (Ip[9], Ip[10], shift_mag[0], ST1[9]);
    mux_2to1 m10 (Ip[10], 1'b0, shift_mag[0], ST1[10]);
    
    mux_2to1 m00 (ST1[0], ST1[2], shift_mag[1], ST2[0]);
    mux_2to1 m11 (ST1[1], ST1[3], shift_mag[1], ST2[1]);
    mux_2to1 m22 (ST1[2], ST1[4], shift_mag[1], ST2[2]);
    mux_2to1 m33 (ST1[3], ST1[5], shift_mag[1], ST2[3]);
    mux_2to1 m44 (ST1[4], ST1[6], shift_mag[1], ST2[4]);
    mux_2to1 m55 (ST1[5], ST1[7], shift_mag[1], ST2[5]);
    mux_2to1 m66 (ST1[6], ST1[8], shift_mag[1], ST2[6]);
    mux_2to1 m77 (ST1[7], ST1[9], shift_mag[1], ST2[7]);
    mux_2to1 m88 (ST1[8], ST1[10], shift_mag[1], ST2[8]);
    mux_2to1 m99 (ST1[9], 1'b0, shift_mag[1], ST2[9]); 
    mux_2to1 m1010 (ST1[10], 1'b0, shift_mag[1], ST2[10]);
    
    mux_2to1 m000 (ST2[0], ST2[4], shift_mag[2], ST3[0]);
    mux_2to1 m111 (ST2[1], ST2[5], shift_mag[2], ST3[1]);
    mux_2to1 m222 (ST2[2], ST2[6], shift_mag[2], ST3[2]);
    mux_2to1 m333 (ST2[3], ST2[7], shift_mag[2], ST3[3]);
    mux_2to1 m444 (ST2[4], ST2[8], shift_mag[2], ST3[4]);
    mux_2to1 m555 (ST2[5], ST2[9], shift_mag[2], ST3[5]);
    mux_2to1 m666 (ST2[6], ST2[10], shift_mag[2], ST3[6]);
    mux_2to1 m777 (ST2[7], 1'b0, shift_mag[2], ST3[7]);
    mux_2to1 m888 (ST2[8], 1'b0, shift_mag[2], ST3[8]);
    mux_2to1 m999 (ST2[9], 1'b0, shift_mag[2], ST3[9]);
    mux_2to1 m101010 (ST2[10], 1'b0, shift_mag[2], ST3[10]);
    
    mux_2to1 m0000 (ST3[0], ST3[8], shift_mag[3], ST4[0]);
    mux_2to1 m1111 (ST3[1], ST3[9], shift_mag[3], ST4[1]);
    mux_2to1 m2222 (ST3[2], ST3[10], shift_mag[3], ST4[2]);
    mux_2to1 m3333 (ST3[3], 1'b0, shift_mag[3], ST4[3]);
    mux_2to1 m4444 (ST3[4], 1'b0, shift_mag[3], ST4[4]);
    mux_2to1 m5555 (ST3[5], 1'b0, shift_mag[3], ST4[5]);
    mux_2to1 m6666 (ST3[6], 1'b0, shift_mag[3], ST4[6]);
    mux_2to1 m7777 (ST3[7], 1'b0, shift_mag[3], ST4[7]);
    mux_2to1 m8888 (ST3[8], 1'b0, shift_mag[3], ST4[8]);
    mux_2to1 m9999 (ST3[9], 1'b0, shift_mag[3], ST4[9]);
    mux_2to1 m10101010 (ST3[10], 1'b0, shift_mag[3], ST4[10]);
    
    mux_2to1 m00000 (ST4[0], 1'b0, shift_mag[4], Op[0]);
    mux_2to1 m11111 (ST4[1], 1'b0, shift_mag[4], Op[1]);
    mux_2to1 m22222 (ST4[2], 1'b0, shift_mag[4], Op[2]);
    mux_2to1 m33333 (ST4[3], 1'b0, shift_mag[4], Op[3]);
    mux_2to1 m44444 (ST4[4], 1'b0, shift_mag[4], Op[4]);
    mux_2to1 m55555 (ST4[5], 1'b0, shift_mag[4], Op[5]);
    mux_2to1 m66666 (ST4[6], 1'b0, shift_mag[4], Op[6]);
    mux_2to1 m77777 (ST4[7], 1'b0, shift_mag[4], Op[7]);
    mux_2to1 m88888 (ST4[8], 1'b0, shift_mag[4], Op[8]);
    mux_2to1 m99999 (ST4[9], 1'b0, shift_mag[4], Op[9]);
    mux_2to1 m1010101010 (ST4[10], 1'b0, shift_mag[4], Op[10]);

endmodule
