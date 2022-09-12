`include "barrel_shifter_16bit_left.v"
`include "barrel_shifter_16bit_right.v"

module barrelShifter( Ip, shift_mag, dir, Op);
	input [16:1] Ip;
	input [4:1] shift_mag;
	input dir;				//left=0, right=1
	output [16:1] Op;
	
	wire [16:1] Opr, Opl;

	wire [16:1] sl, sr;
	barrelShifterRight BSR ( Ip, shift_mag, Opr); 
	barrelShifterLeft BSL ( Ip, shift_mag, Opl);
	
	assign Op=dir?Opl:Opr;
	
endmodule
