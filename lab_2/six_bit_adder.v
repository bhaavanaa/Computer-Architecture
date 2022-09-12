`include "fulladder1.v"
module six_bit_adder(A, B, C, sum, carry);
	input [5:0] A, B;	
	input C;
	output [5:0] sum;
	output carry;
	wire W0, W1, W2, W3, W4;
	fulladder1 FA_0(A[0], B[0], C, sum[0], W0);
	fulladder1 FA_1(A[1], B[1], W0, sum[1], W1);
	fulladder1 FA_2(A[2], B[2], W1, sum[2], W2);
	fulladder1 FA_3(A[3], B[3], W2, sum[3], W3);
	fulladder1 FA_4(A[4], B[4], W3, sum[4], W4);
	fulladder1 FA_5(A[5], B[5], W4, sum[5], carry);
endmodule
