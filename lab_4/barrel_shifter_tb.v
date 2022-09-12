`include "barrel_shifter.v"
module top;
reg [15:0] Ip;
reg [3:0] shift_mag;
reg dir;
wire [15:0] Op;

barrelShifter BS ( Ip, shift_mag, dir, Op);

initial
	begin
		Ip=10'b1001010111; shift_mag=4'b0011; dir=1'b1;
		#5 Ip=10'b1001010111; shift_mag=4'b0011; dir=1'b0;
end
initial
	begin
		$monitor("Ip=%b, shift_mag=%b, dir=%b, Op=%b",  Ip, shift_mag, dir, Op);
end
endmodule
