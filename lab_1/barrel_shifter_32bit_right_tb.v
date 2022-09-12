`include "barrel_shifter_32bit_right.v"
module top;
reg [10:0] Ip;
reg [4:0] shift_mag;
wire [10:0] Op;
barrelShifterRight V_0 ( Ip, shift_mag, Op);
initial
	begin
		Ip=10'b10011001110; shift_mag=5'b00011;
end
initial
	begin
		$monitor("Ip=%b, shift_mag=%b, Op=%b",  Ip, shift_mag, Op);
end
endmodule
