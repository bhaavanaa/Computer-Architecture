`include "eight_bit_addercop.v"
module sixteen_bit_addercop(A, B, C, sum, carry);
	input[15:0] A, B;	
	input C;
	output[15:0] sum;
	output carry;
	wire W0;
	eight_bit_addercop EBA_0(A[7:0], B[7:0], C, sum[7:0], W0);
	eight_bit_addercop EBA_1(A[15:8], B[15:8], W0, sum[15:8], carry);
endmodule
