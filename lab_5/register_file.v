`include "mux_32x1.v"
`include "decoder.v"
`include "dff.v"


module register_file(read1, read2, write, data, out_read1, out_read2);


	input [5:1] read1, read2, write;
	input [16:1] data;
	output [16:1] out_read1, out_read2;


	wire [31:0] d1, d2;
	wire [15:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, wr0, wr1, wr2, wr3, wr4, wr5, wr6, wr7, wr8, wr9, wr10, wr11, wr12, wr13, wr14, wr15, wr16, wr17, wr18, wr19, wr20, wr21, wr22, wr23, wr24, wr25, wr26, wr27, wr28, wr29, wr30, wr31;


	//assign data=16'b1111111111111111;
	//assign write=5'b00010;


//WRITE OPERATION
	decoder d_read1 (write, d1);

	dff16 f0 (data, d1[0], reset, w0);
	dff16 f1 (data, d1[1], reset, w1);
	dff16 f2 (data, d1[2], reset, w2);
	dff16 f3 (data, d1[3], reset, w3);
	dff16 f4 (data, d1[4], reset, w4);
	dff16 f5 (data, d1[5], reset, w5);
	dff16 f6 (data, d1[6], reset, w6);
	dff16 f7 (data, d1[7], reset, w7);
	dff16 f8 (data, d1[8], reset, w8);
	dff16 f9 (data, d1[9], reset, w9);
	dff16 f10 (data, d1[10], reset, w10);
	dff16 f11 (data, d1[11], reset, w11);
	dff16 f12 (data, d1[12], reset, w12);
	dff16 f13 (data, d1[13], reset, w13);
	dff16 f14 (data, d1[14], reset, w14);
	dff16 f15 (data, d1[15], reset, w15);
	dff16 f16 (data, d1[16], reset, w16);
	dff16 f17 (data, d1[17], reset, w17);
	dff16 f18 (data, d1[18], reset, w18);
	dff16 f19 (data, d1[19], reset, w19);
	dff16 f20 (data, d1[20], reset, w20);
	dff16 f21 (data, d1[21], reset, w21);
	dff16 f22 (data, d1[22], reset, w22);
	dff16 f23 (data, d1[23], reset, w23);
	dff16 f24 (data, d1[24], reset, w24);
	dff16 f25 (data, d1[25], reset, w25);
	dff16 f26 (data, d1[26], reset, w26);
	dff16 f27 (data, d1[27], reset, w27);
	dff16 f28 (data, d1[28], reset, w28);
	dff16 f29 (data, d1[29], reset, w29);
	dff16 f30 (data, d1[30], reset, w30);
	dff16 f31 (data, d1[31], reset, w31);


	initial
    $monitor("%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b", data, write, d1, w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31);


	/*decoder d_read2 (read2, d2);

	dff16 ff0 ({16{d2[0]}}, clk, reset, wr0);
	dff16 ff1 ({16{d2[1]}}, clk, reset, wr1);
	dff16 ff2 ({16{d2[2]}}, clk, reset, wr2);
	dff16 ff3 ({16{d2[3]}}, clk, reset, wr3);
	dff16 ff4 ({16{d2[4]}}, clk, reset, wr4);
	dff16 ff5 ({16{d2[5]}}, clk, reset, wr5);
	dff16 ff6 ({16{d2[6]}}, clk, reset, wr6);
	dff16 ff7 ({16{d2[7]}}, clk, reset, wr7);
	dff16 ff8 ({16{d2[8]}}, clk, reset, wr8);
	dff16 ff9 ({16{d2[9]}}, clk, reset, wr9);
	dff16 ff10 ({16{d2[10]}}, clk, reset, wr10);
	dff16 ff11 ({16{d2[11]}}, clk, reset, wr11);
	dff16 ff12 ({16{d2[12]}}, clk, reset, wr12);
	dff16 ff13 ({16{d2[13]}}, clk, reset, wr13);
	dff16 ff14 ({16{d2[14]}}, clk, reset, wr14);
	dff16 ff15 ({16{d2[15]}}, clk, reset, wr15);
	dff16 ff16 ({16{d2[16]}}, clk, reset, wr16);
	dff16 ff17 ({16{d2[17]}}, clk, reset, wr17);
	dff16 ff18 ({16{d2[18]}}, clk, reset, wr18);
	dff16 ff19 ({16{d2[19]}}, clk, reset, wr19);
	dff16 ff20 ({16{d2[20]}}, clk, reset, wr20);
	dff16 ff21 ({16{d2[21]}}, clk, reset, wr21);
	dff16 ff22 ({16{d2[22]}}, clk, reset, wr22);
	dff16 ff23 ({16{d2[23]}}, clk, reset, wr23);
	dff16 ff24 ({16{d2[24]}}, clk, reset, wr24);
	dff16 ff25 ({16{d2[25]}}, clk, reset, wr25);
	dff16 ff26 ({16{d2[26]}}, clk, reset, wr26);
	dff16 ff27 ({16{d2[27]}}, clk, reset, wr27);
	dff16 ff28 ({16{d2[28]}}, clk, reset, wr28);
	dff16 ff29 ({16{d2[29]}}, clk, reset, wr29);
	dff16 ff30 ({16{d2[30]}}, clk, reset, wr30);
	dff16 ff31 ({16{d2[31]}}, clk, reset, wr31);

	mux_32x1 m (w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31, read1, out_read1);
	mux_32x1 mr (wr0, wr1, wr2, wr3, wr4, wr5, wr6, wr7, wr8, wr9, wr10, wr11, wr12, wr13, wr14, wr15, wr16, wr17, wr18, wr19, wr20, wr21, wr22, wr23, wr24, wr25, wr26, wr27, wr28, wr29, wr30, wr31, read2, out_read2);

	decoder d_write (write, d3);

	dff16 fff0 ({16{d3[0]}}, clk, reset, wrw0);
	dff16 fff1 ({16{d3[1]}}, clk, reset, wrw1);
	dff16 fff2 ({16{d3[2]}}, clk, reset, wrw2);
	dff16 fff3 ({16{d3[3]}}, clk, reset, wrw3);
	dff16 fff4 ({16{d3[4]}}, clk, reset, wrw4);
	dff16 fff5 ({16{d3[5]}}, clk, reset, wrw5);
	dff16 fff6 ({16{d3[6]}}, clk, reset, wrw6);
	dff16 fff7 ({16{d3[7]}}, clk, reset, wrw7);
	dff16 fff8 ({16{d3[8]}}, clk, reset, wrw8);
	dff16 fff9 ({16{d3[9]}}, clk, reset, wrw9);
	dff16 fff10 ({16{d3[10]}}, clk, reset, wrw10);
	dff16 fff11 ({16{d3[11]}}, clk, reset, wrw11);
	dff16 fff12 ({16{d3[12]}}, clk, reset, wrw12);
	dff16 fff13 ({16{d3[13]}}, clk, reset, wrw13);
	dff16 fff14 ({16{d3[14]}}, clk, reset, wrw14);
	dff16 fff15 ({16{d3[15]}}, clk, reset, wrw15);
	dff16 fff16 ({16{d3[16]}}, clk, reset, wrw16);
	dff16 fff17 ({16{d3[17]}}, clk, reset, wrw17);
	dff16 fff18 ({16{d3[18]}}, clk, reset, wrw18);
	dff16 fff19 ({16{d3[19]}}, clk, reset, wrw19);
	dff16 fff20 ({16{d3[20]}}, clk, reset, wrw20);
	dff16 fff21 ({16{d3[21]}}, clk, reset, wrw21);
	dff16 fff22 ({16{d3[22]}}, clk, reset, wrw22);
	dff16 fff23 ({16{d3[23]}}, clk, reset, wrw23);
	dff16 fff24 ({16{d3[24]}}, clk, reset, wrw24);
	dff16 fff25 ({16{d3[25]}}, clk, reset, wrw25);
	dff16 fff26 ({16{d3[26]}}, clk, reset, wrw26);
	dff16 fff27 ({16{d3[27]}}, clk, reset, wrw27);
	dff16 fff28 ({16{d3[28]}}, clk, reset, wrw28);
	dff16 fff29 ({16{d3[29]}}, clk, reset, wrw29);
	dff16 fff30 ({16{d3[30]}}, clk, reset, wrw30);
	dff16 fff31 ({16{d3[31]}}, clk, reset, wrw31);
*/
endmodule