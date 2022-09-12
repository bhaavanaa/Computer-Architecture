`include "sixteen_bit_adder.v"
`include "dff.v"

module instruction_fetch(pc, clk, reset, ins);
	input clk, reset;
	output [15:0] ins;
	output [15:0] pc;
	reg [15:0] instr_mem [1023:0];

	wire [15:0] sum;
	wire car;

	sixteen_bit_adder t (pc, 16'd1, 1'b0, sum, car);
	dff16 d (sum, clk, reset, pc);

	assign ins=instr_mem[pc];

	initial begin
		instr_mem[0]=16'd10;
		instr_mem[6]=16'd32;
	end

endmodule
