`include "four_bit_adder.v"
module eight_bit_adder(A, B, C, sum, carry);
	input[7:0] A, B;	
	input C;
	output[7:0] sum;
	output carry;
	wire W0;
	four_bit_adder FBA_0(A[3:0], B[3:0], C, sum[3:0], W0);
	four_bit_adder FBA_1(A[7:4], B[7:4], W0, sum[7:4], carry);
endmodule
