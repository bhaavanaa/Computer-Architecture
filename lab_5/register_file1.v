//`include "mux_32x1.v"
`include "decoder.v"
`include "dff.v"


module register_file(read1, read2, write, data, wen, out_read1, out_read2);


	input [4:0] read1, read2, write;
	input [16:1] data;
	input wen;
	output [16:1] out_read1, out_read2;


	wire [31:0] d1, r1, r2;
	wire [15:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, wr0, wr1, wr2, wr3, wr4, wr5, wr6, wr7, wr8, wr9, wr10, wr11, wr12, wr13, wr14, wr15, wr16, wr17, wr18, wr19, wr20, wr21, wr22, wr23, wr24, wr25, wr26, wr27, wr28, wr29, wr30, wr31;

	//assign data=16'b1111111111111111;
	//assign write=5'b00010;


//WRITE OPERATION
	decoder d_write1 (write, d1);

	dff16 f0 (data, wen&d1[0]&~write[4]&~write[3]&~write[2]&~write[1]&~write[0], reset, w0);
	dff16 f1 (data, wen&d1[1]&~write[4]&~write[3]&~write[2]&~write[1]&write[0], reset, w1);
	dff16 f2 (data, wen&d1[2]&~write[4]&~write[3]&~write[2]&write[1]&~write[0], reset, w2);
	dff16 f3 (data, wen&d1[3]&~write[4]&~write[3]&~write[2]&write[1]&write[0], reset, w3);
	dff16 f4 (data, wen&d1[4]&~write[4]&~write[3]&write[2]&~write[1]&~write[0], reset, w4);
	dff16 f5 (data, wen&d1[5]&~write[4]&~write[3]&write[2]&~write[1]&write[0], reset, w5);
	dff16 f6 (data, wen&d1[6]&~write[4]&~write[3]&write[2]&write[1]&~write[0], reset, w6);
	dff16 f7 (data, wen&d1[7]&~write[4]&~write[3]&write[2]&write[1]&write[0], reset, w7);
	dff16 f8 (data, wen&d1[8]&~write[4]&write[3]&~write[2]&~write[1]&~write[0], reset, w8);
	dff16 f9 (data, wen&d1[9]&~write[4]&write[3]&~write[2]&~write[1]&write[0], reset, w9);
	dff16 f10 (data, wen&d1[10]&~write[4]&write[3]&~write[2]&write[1]&~write[0], reset, w10);
	dff16 f11 (data, wen&d1[11]&~write[4]&write[3]&~write[2]&write[1]&write[0], reset, w11);
	dff16 f12 (data, wen&d1[12]&~write[4]&write[3]&write[2]&~write[1]&~write[0], reset, w12);
	dff16 f13 (data, wen&d1[13]&~write[4]&write[3]&write[2]&~write[1]&write[0], reset, w13);
	dff16 f14 (data, wen&d1[14]&~write[4]&write[3]&write[2]&write[1]&~write[0], reset, w14);
	dff16 f15 (data, wen&d1[15]&~write[4]&write[3]&write[2]&write[1]&write[0], reset, w15);
	dff16 f16 (data, wen&d1[16]&write[4]&~write[3]&~write[2]&~write[1]&~write[0], reset, w16);
	dff16 f17 (data, wen&d1[17]&write[4]&~write[3]&~write[2]&~write[1]&write[0], reset, w17);
	dff16 f18 (data, wen&d1[18]&write[4]&~write[3]&~write[2]&write[1]&~write[0], reset, w18);
	dff16 f19 (data, wen&d1[19]&write[4]&~write[3]&~write[2]&write[1]&write[0], reset, w19);
	dff16 f20 (data, wen&d1[20]&write[4]&~write[3]&write[2]&~write[1]&~write[0], reset, w20);
	dff16 f21 (data, wen&d1[21]&write[4]&~write[3]&write[2]&~write[1]&write[0], reset, w21);
	dff16 f22 (data, wen&d1[22]&write[4]&~write[3]&write[2]&write[1]&~write[0], reset, w22);
	dff16 f23 (data, wen&d1[23]&write[4]&~write[3]&write[2]&write[1]&write[0], reset, w23);
	dff16 f24 (data, wen&d1[24]&write[4]&write[3]&~write[2]&~write[1]&~write[0], reset, w24);
	dff16 f25 (data, wen&d1[25]&write[4]&write[3]&~write[2]&~write[1]&write[0], reset, w25);
	dff16 f26 (data, wen&d1[26]&write[4]&write[3]&~write[2]&write[1]&~write[0], reset, w26);
	dff16 f27 (data, wen&d1[27]&write[4]&write[3]&~write[2]&write[1]&write[0], reset, w27);
	dff16 f28 (data, wen&d1[28]&write[4]&write[3]&write[2]&~write[1]&~write[0], reset, w28);
	dff16 f29 (data, wen&d1[29]&write[4]&write[3]&write[2]&~write[1]&write[0], reset, w29);
	dff16 f30 (data, wen&d1[30]&write[4]&write[3]&write[2]&write[1]&~write[0], reset, w30);
	dff16 f31 (data, wen&d1[31]&write[4]&write[3]&write[2]&write[1]&write[0], reset, w31);


//READ1 OPERATION
	decoder d_read1 (read1, r1);
	assign out_read1={16{r1[0]}}&w0 | {16{r1[1]}}&w1 | {16{r1[2]}}&w2 | {16{r1[3]}}&w3 | {16{r1[4]}}&w4 | {16{r1[5]}}&w5 | {16{r1[6]}}&w6 | {16{r1[7]}}&w7 | {16{r1[8]}}&w8 | {16{r1[9]}}&w9 | {16{r1[10]}}&w10 | {16{r1[11]}}&w11 | {16{r1[12]}}&w12 | {16{r1[13]}}&w13 | {16{r1[14]}}&w14 | {16{r1[15]}}&w15 | {16{r1[16]}}&w16 | {16{r1[17]}}&w17 | {16{r1[18]}}&w18 | {16{r1[19]}}&w19 | {16{r1[20]}}&w20 | {16{r1[21]}}&w21 | {16{r1[22]}}&w22 | {16{r1[23]}}&w23 | {16{r1[24]}}&w24 | {16{r1[25]}}&w25 | {16{r1[26]}}&w26 | {16{r1[27]}}&w27 | {16{r1[28]}}&w28 | {16{r1[29]}}&w29 | {16{r1[30]}}&w30 | {16{r1[31]}}&w31;


//READ2 OPERATION
	decoder d_read2 (read2, r2);
	assign out_read2={16{r2[0]}}&w0 | {16{r2[1]}}&w1 | {16{r2[2]}}&w2 | {16{r2[3]}}&w3 | {16{r2[4]}}&w4 | {16{r2[5]}}&w5 | {16{r2[6]}}&w6 | {16{r2[7]}}&w7 | {16{r2[8]}}&w8 | {16{r2[9]}}&w9 | {16{r2[10]}}&w10 | {16{r2[11]}}&w11 | {16{r2[12]}}&w12 | {16{r2[13]}}&w13 | {16{r2[14]}}&w14 | {16{r2[15]}}&w15 | {16{r2[16]}}&w16 | {16{r2[17]}}&w17 | {16{r2[18]}}&w18 | {16{r2[19]}}&w19 | {16{r2[20]}}&w20 | {16{r2[21]}}&w21 | {16{r2[22]}}&w22 | {16{r2[23]}}&w23 | {16{r2[24]}}&w24 | {16{r2[25]}}&w25 | {16{r2[26]}}&w26 | {16{r2[27]}}&w27 | {16{r2[28]}}&w28 | {16{r2[29]}}&w29 | {16{r2[30]}}&w30 | {16{r2[31]}}&w31;

	
	initial
    $monitor("data=%b wen=%b write=%b d1=%b\nreg: %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b \nread1=%b out_read1=%b\nread2=%b out_read2=%b\n", data, wen, write, d1, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, read1, out_read1, read2, out_read2);



endmodule