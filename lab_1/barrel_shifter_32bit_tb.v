`include "barrel_shifter_32bit.v"
module top;
reg [9:0] Ip;
reg [4:0] shift_mag;
wire [9:0] Op;
barrelShifter V_0 ( Ip, shift_mag, Op);
initial
	begin
		Ip=10'b1001100111; shift_mag=5'b00001;
end
initial
	begin
		$monitor("Ip=%b, shift_mag=%b, Op=%b",  Ip, shift_mag, Op);
end
endmodule
