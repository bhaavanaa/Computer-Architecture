`include "cache_design_final.v"

module top;

	reg [15:1] ic_address;							
	reg ic_enable;
	reg [15:0] ic_write_data;
	reg [15:1] dc_read_address, dc_write_address;		
	reg [15:0] dc_write_data;
	reg clk;
	wire [15:0] ic_read_output;
	wire [15:0] dc_read_output;

	cache_design cd (ic_address, ic_enable, ic_write_data, dc_read_address, dc_write_address, dc_write_data, clk, ic_read_output, dc_read_output);

	initial
		begin
			clk = 0;
	end

	always 
		#50 clk = !clk;

	
	// instruction cache
	initial
		begin
	
			#100
		   	ic_address = 15'd0;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd23;

		    #100
		   	ic_address = 15'd1;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd25;

		    #100
		   	ic_address = 15'd2;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd95;

		    #100
		   	ic_address = 15'd3;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd84;
		    #100
		   	ic_address = 15'd4;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd16;
		    #100
		   	ic_address = 15'd5;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd105;
		    #100
		   	ic_address = 15'd6;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd105;

		    #100
		   	ic_address = 15'd7;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd105;

		    #100
		   	ic_address = 15'd1;
		    ic_enable = 1'b0;

		    #100
		   	ic_address = 15'd0;
		    ic_enable = 1'b0;

		    #100
		   	ic_address = 15'b010000000000000;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd54;

		    #100
		   	ic_address = 15'b010000000000001;
		    ic_enable = 1'b1;
		    ic_write_data = 16'd1020;

		    #100
		   	ic_address = 15'd6;
		    ic_enable = 1'b0;

		    #100
		   	ic_address = 15'd2;
		    ic_enable = 1'b0;
		    
		    #1500
		    $finish;
		end
	

	// data cache
	initial
		begin
			
		    #100
		    dc_write_address = 15'd8;
		    dc_read_address = 15'd8;
		    dc_write_data = 16'd292;

		    #100
		    dc_write_address = 15'd9;
		    dc_read_address = 15'd8;
		    dc_write_data = 16'd3832;

		    #100
		    dc_write_address = 15'd10;
		    dc_read_address = 15'd10;
		    dc_write_data = 16'd32;

		    #100
		    dc_write_address = 15'd11;
		    dc_read_address = 15'd10;
		    dc_write_data = 16'd322;
		    
		    #100
		    dc_write_address = 15'd12;
		    dc_read_address = 15'd11;
		    dc_write_data = 16'd3132;

		    #100
		    dc_write_address = 15'd13;
		    dc_read_address = 15'd13;
		    dc_write_data = 16'd832;

		    #100
		    dc_write_address = 15'd14;
		    dc_read_address = 15'd11;
		    dc_write_data = 16'd3832;

		    #100
		    dc_write_address = 15'd15;
		    dc_read_address = 15'd12;
		    dc_write_data = 16'd3232;

		    #100
		    dc_write_address = 15'b010000000001001;
		    dc_read_address = 15'd8;
		    dc_write_data = 16'd15;

		    #100
		    dc_write_address = 15'd8;
		    dc_read_address = 15'b010000000001001;
		    dc_write_data = 16'd12;

		    #1000 
    		$finish;
		end


	always@(*)	
		begin
			$display("ic_address = %d, ic_enable = %d, ic_write_data = %d, ic_read_output = %d\ndc_read_address = %d, dc_write_address = %d, dc_write_data = %d, dc_read_output = %d\n", ic_address, ic_enable, ic_write_data, ic_read_output, dc_read_address, dc_write_address, dc_write_data, dc_read_output);
	end


endmodule