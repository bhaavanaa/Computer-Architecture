`include "fulladder1.v"
module eleven_bit_adder(A, B, C, sum, carry);
	input [10:0] A, B;	
	input C;
	output [10:0] sum;
	output carry;
	wire W0, W1, W2, W3, W4, W5, W6, W7, W8, W9;
	fulladder1 FA_0(A[0], B[0], C, sum[0], W0);
	fulladder1 FA_1(A[1], B[1], W0, sum[1], W1);
	fulladder1 FA_2(A[2], B[2], W1, sum[2], W2);
	fulladder1 FA_3(A[3], B[3], W2, sum[3], W3);
	fulladder1 FA_4(A[4], B[4], W3, sum[4], W4);
	fulladder1 FA_5(A[5], B[5], W4, sum[5], W5);
	fulladder1 FA_6(A[6], B[6], W5, sum[6], W6);
	fulladder1 FA_7(A[7], B[7], W6, sum[7], W7);
	fulladder1 FA_8(A[8], B[8], W7, sum[8], W8);
	fulladder1 FA_9(A[9], B[9], W8, sum[9], W9);
	fulladder1 FA_10(A[10], B[10], W9, sum[10], carry);
endmodule
