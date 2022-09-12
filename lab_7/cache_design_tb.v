`include "cache_design.v"

module top;

	// reg [15:1] ic_address;			
	// reg ic_enable;
	// reg [15:0] ic_write_data;
	reg clk;
	// wire [15:0] ic_read_output;

	// instruction_cache ic (ic_address, ic_enable, ic_write_data, clk, ic_read_output);


	reg [15:1] dc_read_address, dc_write_address;			
	reg [15:0] dc_write_data;
	wire [15:0] dc_read_output;

	data_cache dc (dc_read_address, dc_write_address, dc_write_data, clk, dc_read_output);


	initial
		begin
			clk =0;
	end

	always 
		#10 clk = !clk;

	initial
		begin
		    // ic_address = 15'b000000000000011; ic_enable = 1'b1; ic_write_data = 16'b1111101010111011;
		    // #10 ic_address = 15'b00000000000001; ic_enable = 1'b1; ic_write_data = 16'b1111101010111111;
		    // #10 ic_address = 15'b00000000000000; ic_enable = 1'b1; ic_write_data = 16'b1111000011110000;
		    // #10 ic_address = 15'b00000000000001; ic_enable = 1'b0;
		    // #10 ic_address = 15'b00000011000011; ic_enable = 1'b0;
	
		    #20 dc_read_address = 15'b000000000000011; dc_write_address = 15'b000000000010011; dc_write_data = 16'b0001101010111011;
		    #20 dc_read_address = 15'b000000000010011; dc_write_address = 15'b000000000010111; dc_write_data = 16'b0000001010111111;
		    #20 dc_read_address = 15'b000000000010111; dc_write_address = 15'b000000110010111; dc_write_data = 16'b0000000011110000;
		    #20 dc_read_address = 15'b000000110010111; dc_write_address = 15'b000000000110011; dc_write_data = 16'b0000000011110011;
		    #20 dc_read_address = 15'b000000000110011; dc_write_address = 15'b000000000111111; dc_write_data = 16'b0001100011000011;
	end

	always @(posedge clk)
		begin
    		//$monitor($time, " ic_address = %b, ic_enable = %b, ic_write_data = %b, ic_read_output = %b", ic_address, ic_enable, ic_write_data, ic_read_output);
			$monitor($time, " dc_read_address = %b, dc_write_address = %b, dc_write_data = %b, dc_read_output = %b", dc_read_address, dc_write_address, dc_write_data, dc_read_output);
	end

	initial
    	#100 $finish;

endmodule