`include "float_mul.v"
module top;
reg[16:1] A, B;
wire[16:1] result;
wire overflow;
float_mul FA(A, B, result, overflow);
initial
	begin
		A=16'b0101010101011100; B=16'b0101000000101011;
end

initial
	begin
		$monitor(" A = %b, B = %b, result = %b, overflow = %b", A, B, result, overflow);
end
endmodule
