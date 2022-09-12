`include "float_adder4.v"
module top;

reg[16:1] Ain, Bin;
reg sign;
wire [16:1] Cin;
wire overflow, underflow;

float_adder FA (Ain, Bin, sign, Cin, overflow, underflow);
initial
	begin
		Ain=16'b0010011001100011; Bin=16'b0010000000000001; sign=1'b1;
end

initial
	begin
		$monitor($time,"  A = %b,  B = %b,  sign = %b,  C = %b \n\toverflow = %b, underflow = %b", Ain, Bin, sign, Cin, overflow, underflow);
end
endmodule
