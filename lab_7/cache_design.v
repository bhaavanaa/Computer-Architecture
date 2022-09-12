module cache(address, enable, write_data, clk, read_output);
	
	input [15:1] address;			
	input enable;
	input [15:0] write_data;
	input clk;
	output reg [15:0] read_output;

	
	reg [128:1] inst_cache [255:0];				// there are 256 blocks each of size 128 in cache
	reg [128:1] main_memory [4095:0];		// there are 4096 blocks each of size 128 in main memory
	reg [4:1] tag [255:0];
	reg [255:0] valid, dirty;


	reg [12:1] temp;
	integer i;


	initial begin
		for(i=0; i<2048; i=i+1) begin
			valid[i] <= 0;
			dirty[i] <= 0;
		end
	end


	initial begin
		for(i=0; i<255; i=i+1) begin
			tag[i] <= i;
		end
	end


	always @(posedge clk) begin	

		if(address[15:12]==tag[address[11:4]] && (enable==1'b1)) begin	// write hit
			
			$display("inst_cache, write hit");

			if(address[3:1]==3'b000) begin
				inst_cache[address[11:4]][16:1] = write_data;
			end
			if(address[3:1]==3'b001) begin
				inst_cache[address[11:4]][32:17] = write_data;
			end
			if(address[3:1]==3'b010) begin
				inst_cache[address[11:4]][48:33] = write_data;
			end
			if(address[3:1]==3'b011) begin
				inst_cache[address[11:4]][64:49] = write_data;
			end
			if(address[3:1]==3'b100) begin
				inst_cache[address[11:4]][80:65] = write_data;
			end
			if(address[3:1]==3'b101) begin
				inst_cache[address[11:4]][96:81] = write_data;
			end
			if(address[3:1]==3'b110) begin
				inst_cache[address[11:4]][112:97] = write_data;
			end
			if(address[3:1]==3'b111) begin
				inst_cache[address[11:4]][128:113] = write_data;
			end

			dirty[address[11:4]] = 1'b1;
			valid[address[11:4]] = 1'b1;
		end


		if(address[15:12]!=tag[address[11:4]] && (dirty[address[11:4]]==1'b0) && (enable==1'b1)) begin	// write miss not dirty
			
			$display("inst_cache, write miss not dirty");

			inst_cache[address[11:4]]=main_memory[address[15:4]];

			if(address[3:1]==3'b000) begin
				inst_cache[address[11:4]][16:1] = write_data;
			end
			if(address[3:1]==3'b001) begin
				inst_cache[address[11:4]][32:17] = write_data;
			end
			if(address[3:1]==3'b010) begin
				inst_cache[address[11:4]][48:33] = write_data;
			end
			if(address[3:1]==3'b011) begin
				inst_cache[address[11:4]][64:49] = write_data;
			end
			if(address[3:1]==3'b100) begin
				inst_cache[address[11:4]][80:65] = write_data;
			end
			if(address[3:1]==3'b101) begin
				inst_cache[address[11:4]][96:81] = write_data;
			end
			if(address[3:1]==3'b110) begin
				inst_cache[address[11:4]][112:97] = write_data;
			end
			if(address[3:1]==3'b111) begin
				inst_cache[address[11:4]][128:113] = write_data;
			end

			dirty[address[11:4]] = 1'b1;
			tag[address[11:4]] = address[15:12];
			valid[address[11:4]] = 1'b1;
		end
	

		if(address[15:12]!=tag[address[11:4]] && (dirty[address[11:4]]==1'b1) && (enable==1'b1)) begin	// write miss dirty
			
			$display("inst_cache, write miss dirty");

			temp[8:1] = address[11:4];
			temp[12:9] = tag[address[11:4]];

			main_memory[temp] = inst_cache[address[11:4]];

			inst_cache[address[11:4]]=main_memory[address[15:4]];

			if(address[3:1]==3'b000) begin
				inst_cache[address[11:4]][16:1] = write_data;
			end
			if(address[3:1]==3'b001) begin
				inst_cache[address[11:4]][32:17] = write_data;
			end
			if(address[3:1]==3'b010) begin
				inst_cache[address[11:4]][48:33] = write_data;
			end
			if(address[3:1]==3'b011) begin
				inst_cache[address[11:4]][64:49] = write_data;
			end
			if(address[3:1]==3'b100) begin
				inst_cache[address[11:4]][80:65] = write_data;
			end
			if(address[3:1]==3'b101) begin
				inst_cache[address[11:4]][96:81] = write_data;
			end
			if(address[3:1]==3'b110) begin
				inst_cache[address[11:4]][112:97] = write_data;
			end
			if(address[3:1]==3'b111) begin
				inst_cache[address[11:4]][128:113] = write_data;
			end

			dirty[address[11:4]] = 1'b1;
			tag[address[11:4]] = address[15:12];
			valid[address[11:4]] = 1'b1;
		end


		if(address[15:12]==tag[address[11:4]] && (valid[address[11:4]]==1'b1) && (enable==1'b0)) begin	// read hit valid
			
			$display("inst_cache, read hit valid");

			if(address[3:1]==3'b000) begin
				read_output = inst_cache[address[11:4]][16:1];
			end
			if(address[3:1]==3'b001) begin
				read_output = inst_cache[address[11:4]][32:17];
			end
			if(address[3:1]==3'b010) begin
				read_output = inst_cache[address[11:4]][48:33];
			end
			if(address[3:1]==3'b011) begin
				read_output = inst_cache[address[11:4]][64:49];
			end
			if(address[3:1]==3'b100) begin
				read_output = inst_cache[address[11:4]][80:65];
			end
			if(address[3:1]==3'b101) begin
				read_output = inst_cache[address[11:4]][96:81];
			end
			if(address[3:1]==3'b110) begin
				read_output = inst_cache[address[11:4]][112:97];
			end
			if(address[3:1]==3'b111) begin
				read_output = inst_cache[address[11:4]][128:113];
			end
		end


		if(address[15:12]==tag[address[11:4]] && (valid[address[11:4]]==1'b0) && (enable==1'b0)) begin	// read hit invalid
			
			$display("inst_cache, read hit invalid");

			inst_cache[address[11:4]]=main_memory[address[15:4]];

			if(address[3:1]==3'b000) begin
				read_output = inst_cache[address[11:4]][16:1];
			end
			if(address[3:1]==3'b001) begin
				read_output = inst_cache[address[11:4]][32:17];
			end
			if(address[3:1]==3'b010) begin
				read_output = inst_cache[address[11:4]][48:33];
			end
			if(address[3:1]==3'b011) begin
				read_output = inst_cache[address[11:4]][64:49];
			end
			if(address[3:1]==3'b100) begin
				read_output = inst_cache[address[11:4]][80:65];
			end
			if(address[3:1]==3'b101) begin
				read_output = inst_cache[address[11:4]][96:81];
			end
			if(address[3:1]==3'b110) begin
				read_output = inst_cache[address[11:4]][112:97];
			end
			if(address[3:1]==3'b111) begin
				read_output = inst_cache[address[11:4]][128:113];
			end

			valid[address[11:4]] = 1'b1;
		end


		if(address[15:12]!=tag[address[11:4]] && (enable==1'b0) && (dirty[address[11:4]]==1'b1)) begin	// read miss dirty
			
			$display("inst_cache, read miss dirty");

			temp[8:1] = address[11:4];
			temp[12:9] = tag[address[11:4]];

			main_memory[temp] = inst_cache[address[11:4]];

			inst_cache[address[11:4]]=main_memory[address[15:4]];

			if(address[3:1]==3'b000) begin
				read_output = inst_cache[address[11:4]][16:1];
			end
			if(address[3:1]==3'b001) begin
				read_output = inst_cache[address[11:4]][32:17];
			end
			if(address[3:1]==3'b010) begin
				read_output = inst_cache[address[11:4]][48:33];
			end
			if(address[3:1]==3'b011) begin
				read_output = inst_cache[address[11:4]][64:49];
			end
			if(address[3:1]==3'b100) begin
				read_output = inst_cache[address[11:4]][80:65];
			end
			if(address[3:1]==3'b101) begin
				read_output = inst_cache[address[11:4]][96:81];
			end
			if(address[3:1]==3'b110) begin
				read_output = inst_cache[address[11:4]][112:97];
			end
			if(address[3:1]==3'b111) begin
				read_output = inst_cache[address[11:4]][128:113];
			end
		
			tag[address[11:4]] = address[15:12];
			valid[address[11:4]] = 1'b1;
		end


		if(address[15:12]!=tag[address[11:4]] && (enable==1'b0) && (dirty[address[11:4]]==1'b0)) begin	// read miss not dirty
			
			$display("inst_cache, read miss not dirty");

			inst_cache[address[11:4]]=main_memory[address[15:4]];

			if(address[3:1]==3'b000) begin
				read_output = inst_cache[address[11:4]][16:1];
			end
			if(address[3:1]==3'b001) begin
				read_output = inst_cache[address[11:4]][32:17];
			end
			if(address[3:1]==3'b010) begin
				read_output = inst_cache[address[11:4]][48:33];
			end
			if(address[3:1]==3'b011) begin
				read_output = inst_cache[address[11:4]][64:49];
			end
			if(address[3:1]==3'b100) begin
				read_output = inst_cache[address[11:4]][80:65];
			end
			if(address[3:1]==3'b101) begin
				read_output = inst_cache[address[11:4]][96:81];
			end
			if(address[3:1]==3'b110) begin
				read_output = inst_cache[address[11:4]][112:97];
			end
			if(address[3:1]==3'b111) begin
				read_output = inst_cache[address[11:4]][128:113];
			end
		
			tag[address[11:4]] = address[15:12];
			valid[address[11:4]] = 1'b1;
		end

	end

endmodule





module data_cache(read_address, write_address, write_data, clk, read_output);
	
	input [15:1] read_address, write_address;			
	input [15:0] write_data;
	input clk;
	output reg [15:0] read_output;

	
	reg [128:1] dat_cache [255:0];				// there are 256 blocks each of size 128 in cache
	reg [128:1] main_memory [4095:0];		// there are 4096 blocks each of size 128 in main memory
	reg [4:1] tag [255:0];
	reg [255:0] valid, dirty;


	reg [12:1] temp;
	integer i;


	initial begin
		for(i=0; i<2048; i=i+1) begin
			valid[i] <= 0;
			dirty[i] <= 0;
		end
	end


	initial begin
		for(i=0; i<255; i=i+1) begin
			tag[i] <= i;
		end
	end


	always @(posedge clk) begin	

		if(write_address[15:12]==tag[write_address[11:4]]) begin	// write hit
			
			$display("data_cache, write hit");

			if(write_address[3:1]==3'b000) begin
				dat_cache[write_address[11:4]][16:1] = write_data;
			end
			if(write_address[3:1]==3'b001) begin
				dat_cache[write_address[11:4]][32:17] = write_data;
			end
			if(write_address[3:1]==3'b010) begin
				dat_cache[write_address[11:4]][48:33] = write_data;
			end
			if(write_address[3:1]==3'b011) begin
				dat_cache[write_address[11:4]][64:49] = write_data;
			end
			if(write_address[3:1]==3'b100) begin
				dat_cache[write_address[11:4]][80:65] = write_data;
			end
			if(write_address[3:1]==3'b101) begin
				dat_cache[write_address[11:4]][96:81] = write_data;
			end
			if(write_address[3:1]==3'b110) begin
				dat_cache[write_address[11:4]][112:97] = write_data;
			end
			if(write_address[3:1]==3'b111) begin
				dat_cache[write_address[11:4]][128:113] = write_data;
			end

			dirty[write_address[11:4]] = 1'b1;
			valid[write_address[11:4]] = 1'b1;

			$display("write_out = %b", dat_cache[write_address[11:4]]);

		end

		
		if(write_address[15:12]!=tag[write_address[11:4]] && (dirty[write_address[11:4]]==1'b0)) begin	// write miss not dirty
			
			$display("data_cache, write miss not dirty");

			dat_cache[write_address[11:4]]=main_memory[write_address[15:4]];

			if(write_address[3:1]==3'b000) begin
				dat_cache[write_address[11:4]][16:1] = write_data;
			end
			if(write_address[3:1]==3'b001) begin
				dat_cache[write_address[11:4]][32:17] = write_data;
			end
			if(write_address[3:1]==3'b010) begin
				dat_cache[write_address[11:4]][48:33] = write_data;
			end
			if(write_address[3:1]==3'b011) begin
				dat_cache[write_address[11:4]][64:49] = write_data;
			end
			if(write_address[3:1]==3'b100) begin
				dat_cache[write_address[11:4]][80:65] = write_data;
			end
			if(write_address[3:1]==3'b101) begin
				dat_cache[write_address[11:4]][96:81] = write_data;
			end
			if(write_address[3:1]==3'b110) begin
				dat_cache[write_address[11:4]][112:97] = write_data;
			end
			if(write_address[3:1]==3'b111) begin
				dat_cache[write_address[11:4]][128:113] = write_data;
			end

			dirty[write_address[11:4]] = 1'b1;
			tag[write_address[11:4]] = write_address[15:12];
			valid[write_address[11:4]] = 1'b1;

			$display("write_out = %b", dat_cache[write_address[11:4]]);

		end


		if(write_address[15:12]!=tag[write_address[11:4]] && (dirty[write_address[11:4]]==1'b1)) begin	// write miss dirty
			
			$display("data_cache, write miss dirty");

			temp[8:1] = write_address[11:4];
			temp[12:9] = tag[write_address[11:4]];

			main_memory[temp] = dat_cache[write_address[11:4]];

			dat_cache[write_address[11:4]]=main_memory[write_address[15:4]];

			if(write_address[3:1]==3'b000) begin
				dat_cache[write_address[11:4]][16:1] = write_data;
			end
			if(write_address[3:1]==3'b001) begin
				dat_cache[write_address[11:4]][32:17] = write_data;
			end
			if(write_address[3:1]==3'b010) begin
				dat_cache[write_address[11:4]][48:33] = write_data;
			end
			if(write_address[3:1]==3'b011) begin
				dat_cache[write_address[11:4]][64:49] = write_data;
			end
			if(write_address[3:1]==3'b100) begin
				dat_cache[write_address[11:4]][80:65] = write_data;
			end
			if(write_address[3:1]==3'b101) begin
				dat_cache[write_address[11:4]][96:81] = write_data;
			end
			if(write_address[3:1]==3'b110) begin
				dat_cache[write_address[11:4]][112:97] = write_data;
			end
			if(write_address[3:1]==3'b111) begin
				dat_cache[write_address[11:4]][128:113] = write_data;
			end

			dirty[write_address[11:4]] = 1'b1;
			tag[write_address[11:4]] = write_address[15:12];
			valid[write_address[11:4]] = 1'b1;

			$display("write_out = %b", dat_cache[write_address[11:4]]);

		end

	
		if(read_address[15:12]==tag[read_address[11:4]] && (valid[read_address[11:4]]==1'b1)) begin	// read hit valid
			
			$display("data_cache, read hit valid");

			$display("add = %b, read_out = %b", read_address, dat_cache[read_address[11:4]]);

			if(read_address[3:1]==3'b000) begin
				read_output = dat_cache[read_address[11:4]][16:1];
			end
			if(read_address[3:1]==3'b001) begin
				read_output = dat_cache[read_address[11:4]][32:17];
			end
			if(read_address[3:1]==3'b010) begin
				read_output = dat_cache[read_address[11:4]][48:33];
			end
			if(read_address[3:1]==3'b011) begin
				read_output = dat_cache[read_address[11:4]][64:49];
			end
			if(read_address[3:1]==3'b100) begin
				read_output = dat_cache[read_address[11:4]][80:65];
			end
			if(read_address[3:1]==3'b101) begin
				read_output = dat_cache[read_address[11:4]][96:81];
			end
			if(read_address[3:1]==3'b110) begin
				read_output = dat_cache[read_address[11:4]][112:97];
			end
			if(read_address[3:1]==3'b111) begin
				read_output = dat_cache[read_address[11:4]][128:113];
			end
		end


		if(read_address[15:12]==tag[read_address[11:4]] && (valid[read_address[11:4]]==1'b0)) begin	// read hit invalid
			
			$display("data_cache, read hit invalid");

			dat_cache[read_address[11:4]]=main_memory[read_address[15:4]];

			$display("add = %b, read_out = %b", read_address, dat_cache[read_address[11:4]]);

			if(read_address[3:1]==3'b000) begin
				read_output = dat_cache[read_address[11:4]][16:1];
			end
			if(read_address[3:1]==3'b001) begin
				read_output = dat_cache[read_address[11:4]][32:17];
			end
			if(read_address[3:1]==3'b010) begin
				read_output = dat_cache[read_address[11:4]][48:33];
			end
			if(read_address[3:1]==3'b011) begin
				read_output = dat_cache[read_address[11:4]][64:49];
			end
			if(read_address[3:1]==3'b100) begin
				read_output = dat_cache[read_address[11:4]][80:65];
			end
			if(read_address[3:1]==3'b101) begin
				read_output = dat_cache[read_address[11:4]][96:81];
			end
			if(read_address[3:1]==3'b110) begin
				read_output = dat_cache[read_address[11:4]][112:97];
			end
			if(read_address[3:1]==3'b111) begin
				read_output = dat_cache[read_address[11:4]][128:113];
			end

			valid[read_address[11:4]] = 1'b1;
		end


		if(read_address[15:12]!=tag[read_address[11:4]] && (dirty[read_address[11:4]]==1'b1)) begin	// read miss dirty
			
			$display("data_cache, read miss dirty");

			temp[8:1] = read_address[11:4];
			temp[12:9] = tag[read_address[11:4]];

			main_memory[temp] = dat_cache[read_address[11:4]];

			dat_cache[read_address[11:4]]=main_memory[read_address[15:4]];

			$display("add = %b, read_out = %b", read_address, dat_cache[read_address[11:4]]);

			if(read_address[3:1]==3'b000) begin
				read_output = dat_cache[read_address[11:4]][16:1];
			end
			if(read_address[3:1]==3'b001) begin
				read_output = dat_cache[read_address[11:4]][32:17];
			end
			if(read_address[3:1]==3'b010) begin
				read_output = dat_cache[read_address[11:4]][48:33];
			end
			if(read_address[3:1]==3'b011) begin
				read_output = dat_cache[read_address[11:4]][64:49];
			end
			if(read_address[3:1]==3'b100) begin
				read_output = dat_cache[read_address[11:4]][80:65];
			end
			if(read_address[3:1]==3'b101) begin
				read_output = dat_cache[read_address[11:4]][96:81];
			end
			if(read_address[3:1]==3'b110) begin
				read_output = dat_cache[read_address[11:4]][112:97];
			end
			if(read_address[3:1]==3'b111) begin
				read_output = dat_cache[read_address[11:4]][128:113];
			end
		
			tag[read_address[11:4]] = read_address[15:12];
			valid[read_address[11:4]] = 1'b1;
		end



		if(read_address[15:12]!=tag[read_address[11:4]] && (dirty[read_address[11:4]]==1'b0)) begin	// read miss not dirty

			$display("data_cache, read miss not dirty");

			dat_cache[read_address[11:4]]=main_memory[read_address[15:4]];

			$display("add = %b, read_out = %b", read_address, dat_cache[read_address[11:4]]);

			if(read_address[3:1]==3'b000) begin
				read_output = dat_cache[read_address[11:4]][16:1];
			end
			if(read_address[3:1]==3'b001) begin
				read_output = dat_cache[read_address[11:4]][32:17];
			end
			if(read_address[3:1]==3'b010) begin
				read_output = dat_cache[read_address[11:4]][48:33];
			end
			if(read_address[3:1]==3'b011) begin
				read_output = dat_cache[read_address[11:4]][64:49];
			end
			if(read_address[3:1]==3'b100) begin
				read_output = dat_cache[read_address[11:4]][80:65];
			end
			if(read_address[3:1]==3'b101) begin
				read_output = dat_cache[read_address[11:4]][96:81];
			end
			if(read_address[3:1]==3'b110) begin
				read_output = dat_cache[read_address[11:4]][112:97];
			end
			if(read_address[3:1]==3'b111) begin
				read_output = dat_cache[read_address[11:4]][128:113];
			end
		
			tag[read_address[11:4]] = read_address[15:12];
			valid[read_address[11:4]] = 1'b1;
		end

	end

endmodule
