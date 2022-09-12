`include "instruction_fetch.v"

module top;

	reg clk, reset;
	wire [15:0] ins;
	wire [15:0] pc;

	instruction_fetch if1 (pc, clk, reset, ins);

	initial
		begin
			reset=1;
			clk =0;
	end

	always 
	#5  clk =  ! clk; 

	initial begin
		#5 reset=0;
	end


	initial
		begin
	 		$monitor($time, " pc=%b, ins=%b\n", pc, ins);
		end 

	initial
		#100 $finish;
endmodule