`include "float_logic_unit.v"
module top;
reg[16:1] A, B;
reg [3:1] op;
wire[16:1] out;
float_logic_unit FA (A, B, op, out);
initial
	begin
		A=16'b0010011001100011; B=16'b0010000000000001; op=3'b111;
end

initial
    begin
        $monitor("  A = %b,  B = %b,  op=%b,  out = %b", A, B, op, out);
    end
endmodule
