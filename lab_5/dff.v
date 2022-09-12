module dff16(d, clk, reset, q);

	input [15:0] d;
	input clk, reset;
	output reg [15:0] q;

	always @(posedge clk or posedge reset)
	 	if(reset)
	 		q<=16'b0;
	 	else if(clk)
	 		q<=d;
endmodule  
