module cache_design(ic_address, ic_enable, ic_write_data, dc_read_address, dc_write_address, dc_write_data, clk, ic_read_output, dc_read_output);

	input [15:1] ic_address;							// input-output information related to instruction cache
	input ic_enable;
	input [15:0] ic_write_data;
	output reg [15:0] ic_read_output;

	input [15:1] dc_read_address, dc_write_address;		// input-output information related to data cache
	input [15:0] dc_write_data;	
	output reg [15:0] dc_read_output;

	input clk;											// common clk variable to both instruction and data cache

	reg [128:1] inst_cache [1023:0];					// there are 1024 blocks each of size 128 in instruction cache
	reg [2:1] ic_tag [1023:0];
	reg [1023:0] ic_valid, ic_dirty;

	reg [128:1] data_cache [2047:0];					// there are 2048 blocks each of size 128 in data cache
	reg [2047:0] dc_tag;
	reg [2047:0] dc_valid, dc_dirty;

	reg [128:1] main_memory [4095:0];					// there are 4096 blocks each of size 128 in main memory

	reg [12:1] ic_temp;									// other intermediate variables
	reg [12:1] dc_temp;
	integer i;


	initial begin
		for(i=0; i<1024; i=i+1) begin
			ic_valid[i] <= 0;
			ic_dirty[i] <= 0;
			ic_tag[i] <= 0;
		end : for(i=0; i<1024; i=i+1)
	end

	initial begin
		for(i=0; i<2048; i=i+1) begin
			dc_valid[i] <= 0;
			dc_dirty[i] <= 0;
			dc_tag[i] <= 0;
		end
	end
	


	always @(posedge clk) begin

		if(ic_address[15:14]==ic_tag[ic_address[13:4]] && (ic_enable==1'b1) && (ic_valid[ic_address[13:4]]==1'b1)) begin	// write hit valid(instruction cache)
			
			//$display("inst_cache, write hit valid");

			if(ic_address[3:1]==3'b000)
				inst_cache[ic_address[13:4]][16:1] = ic_write_data;
			if(ic_address[3:1]==3'b001) 
				inst_cache[ic_address[13:4]][32:17] = ic_write_data;
			if(ic_address[3:1]==3'b010) 
				inst_cache[ic_address[13:4]][48:33] = ic_write_data;			
			if(ic_address[3:1]==3'b011) 
				inst_cache[ic_address[13:4]][64:49] = ic_write_data;
			if(ic_address[3:1]==3'b100) 
				inst_cache[ic_address[13:4]][80:65] = ic_write_data;
			if(ic_address[3:1]==3'b101) 
				inst_cache[ic_address[13:4]][96:81] = ic_write_data;
			if(ic_address[3:1]==3'b110) 
				inst_cache[ic_address[13:4]][112:97] = ic_write_data;
			if(ic_address[3:1]==3'b111) 
				inst_cache[ic_address[13:4]][128:113] = ic_write_data;
			
			ic_dirty[ic_address[13:4]] = 1'b1;

			//$display("write_out = %b", inst_cache[ic_address[13:4]]);

		end


		if(ic_address[15:14]==ic_tag[ic_address[13:4]] && (ic_enable==1'b1) && (ic_valid[ic_address[13:4]]==1'b0)) begin	// write hit invalid(instruction cache)
			
			//$display("inst_cache, write hit invalid");

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			if(ic_address[3:1]==3'b000)
				inst_cache[ic_address[13:4]][16:1] = ic_write_data;
			if(ic_address[3:1]==3'b001) 
				inst_cache[ic_address[13:4]][32:17] = ic_write_data;
			if(ic_address[3:1]==3'b010) 
				inst_cache[ic_address[13:4]][48:33] = ic_write_data;			
			if(ic_address[3:1]==3'b011) 
				inst_cache[ic_address[13:4]][64:49] = ic_write_data;
			if(ic_address[3:1]==3'b100) 
				inst_cache[ic_address[13:4]][80:65] = ic_write_data;
			if(ic_address[3:1]==3'b101) 
				inst_cache[ic_address[13:4]][96:81] = ic_write_data;
			if(ic_address[3:1]==3'b110) 
				inst_cache[ic_address[13:4]][112:97] = ic_write_data;
			if(ic_address[3:1]==3'b111) 
				inst_cache[ic_address[13:4]][128:113] = ic_write_data;
			
			ic_dirty[ic_address[13:4]] = 1'b1;
			ic_valid[ic_address[13:4]] = 1'b1;

			//$display("write_out = %b", inst_cache[ic_address[13:4]]);

		end


		if(ic_address[15:14]!=ic_tag[ic_address[13:4]] && (ic_dirty[ic_address[13:4]]==1'b0) && (ic_enable==1'b1)) begin	// write miss not dirty(instruction cache)
			
			//$display("inst_cache, write miss not dirty");

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			if(ic_address[3:1]==3'b000) 
				inst_cache[ic_address[13:4]][16:1] = ic_write_data;
			if(ic_address[3:1]==3'b001) 
				inst_cache[ic_address[13:4]][32:17] = ic_write_data;
			if(ic_address[3:1]==3'b010) 
				inst_cache[ic_address[13:4]][48:33] = ic_write_data;			
			if(ic_address[3:1]==3'b011) 
				inst_cache[ic_address[13:4]][64:49] = ic_write_data;			
			if(ic_address[3:1]==3'b100) 
				inst_cache[ic_address[13:4]][80:65] = ic_write_data;			
			if(ic_address[3:1]==3'b101) 
				inst_cache[ic_address[13:4]][96:81] = ic_write_data;			
			if(ic_address[3:1]==3'b110) 
				inst_cache[ic_address[13:4]][112:97] = ic_write_data;			
			if(ic_address[3:1]==3'b111) 
				inst_cache[ic_address[13:4]][128:113] = ic_write_data;

			ic_dirty[ic_address[13:4]] = 1'b1;
			ic_tag[ic_address[13:4]] = ic_address[15:14];
			ic_valid[ic_address[13:4]] = 1'b1;

			//$display("write_out = %b", inst_cache[ic_address[13:4]]);

		end


		if(ic_address[15:14]!=ic_tag[ic_address[13:4]] && (ic_dirty[ic_address[13:4]]==1'b1) && (ic_enable==1'b1)) begin	// write miss dirty(instruction cache)
			
			//$display("inst_cache, write miss dirty");

			ic_temp[10:1] = ic_address[13:4];
			ic_temp[12:11] = ic_tag[ic_address[13:4]];

			main_memory[ic_temp] = inst_cache[ic_address[13:4]];

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			if(ic_address[3:1]==3'b000) 
				inst_cache[ic_address[13:4]][16:1] = ic_write_data;
			if(ic_address[3:1]==3'b001) 
				inst_cache[ic_address[13:4]][32:17] = ic_write_data;			
			if(ic_address[3:1]==3'b010) 
				inst_cache[ic_address[13:4]][48:33] = ic_write_data;			
			if(ic_address[3:1]==3'b011) 
				inst_cache[ic_address[13:4]][64:49] = ic_write_data;			
			if(ic_address[3:1]==3'b100) 
				inst_cache[ic_address[13:4]][80:65] = ic_write_data;			
			if(ic_address[3:1]==3'b101) 
				inst_cache[ic_address[13:4]][96:81] = ic_write_data;			
			if(ic_address[3:1]==3'b110) 
				inst_cache[ic_address[13:4]][112:97] = ic_write_data;		
			if(ic_address[3:1]==3'b111) 
				inst_cache[ic_address[13:4]][128:113] = ic_write_data;

			ic_dirty[ic_address[13:4]] = 1'b1;
			ic_tag[ic_address[13:4]] = ic_address[15:14];
			ic_valid[ic_address[13:4]] = 1'b1;

			//$display("write_out = %b", inst_cache[ic_address[13:4]]);

		end


		if(ic_address[15:14]==ic_tag[ic_address[13:4]] && (ic_valid[ic_address[13:4]]==1'b1) && (ic_enable==1'b0)) begin	// read hit valid(instruction cache)
			
			//$display("inst_cache, read hit valid");

			//$display("add = %b, read_out = %b", ic_address, inst_cache[ic_address[13:4]]);

			if(ic_address[3:1]==3'b000) 
				ic_read_output = inst_cache[ic_address[13:4]][16:1];			
			if(ic_address[3:1]==3'b001) 
				ic_read_output = inst_cache[ic_address[13:4]][32:17];			
			if(ic_address[3:1]==3'b010) 
				ic_read_output = inst_cache[ic_address[13:4]][48:33];			
			if(ic_address[3:1]==3'b011) 
				ic_read_output = inst_cache[ic_address[13:4]][64:49];			
			if(ic_address[3:1]==3'b100) 
				ic_read_output = inst_cache[ic_address[13:4]][80:65];			
			if(ic_address[3:1]==3'b101) 
				ic_read_output = inst_cache[ic_address[13:4]][96:81];			
			if(ic_address[3:1]==3'b110) 
				ic_read_output = inst_cache[ic_address[13:4]][112:97];			
			if(ic_address[3:1]==3'b111) 
				ic_read_output = inst_cache[ic_address[13:4]][128:113];
		end


		if(ic_address[15:14]==ic_tag[ic_address[13:4]] && (ic_valid[ic_address[13:4]]==1'b0) && (ic_enable==1'b0)) begin	// read hit invalid(instruction cache)
			
			//$display("inst_cache, read hit invalid");

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			//$display("add = %b, read_out = %b", ic_address, inst_cache[ic_address[13:4]]);

			if(ic_address[3:1]==3'b000) 
				ic_read_output = inst_cache[ic_address[13:4]][16:1];
			if(ic_address[3:1]==3'b001) 
				ic_read_output = inst_cache[ic_address[13:4]][32:17];			
			if(ic_address[3:1]==3'b010) 
				ic_read_output = inst_cache[ic_address[13:4]][48:33];			
			if(ic_address[3:1]==3'b011) 
				ic_read_output = inst_cache[ic_address[13:4]][64:49];			
			if(ic_address[3:1]==3'b100) 
				ic_read_output = inst_cache[ic_address[13:4]][80:65];			
			if(ic_address[3:1]==3'b101) 
				ic_read_output = inst_cache[ic_address[13:4]][96:81];			
			if(ic_address[3:1]==3'b110) 
				ic_read_output = inst_cache[ic_address[13:4]][112:97];			
			if(ic_address[3:1]==3'b111) 
				ic_read_output = inst_cache[ic_address[13:4]][128:113];			

			ic_valid[ic_address[13:4]] = 1'b1;
		end


		if(ic_address[15:14]!=ic_tag[ic_address[13:4]] && (ic_enable==1'b0) && (ic_dirty[ic_address[13:4]]==1'b0)) begin	// read miss not dirty(instruction cache)
			
			//$display("inst_cache, read miss not dirty");

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			//$display("add = %b, read_out = %b", ic_address, inst_cache[ic_address[13:4]]);

			if(ic_address[3:1]==3'b000) 
				ic_read_output = inst_cache[ic_address[13:4]][16:1];			
			if(ic_address[3:1]==3'b001) 
				ic_read_output = inst_cache[ic_address[13:4]][32:17];			
			if(ic_address[3:1]==3'b010) 
				ic_read_output = inst_cache[ic_address[13:4]][48:33];			
			if(ic_address[3:1]==3'b011) 
				ic_read_output = inst_cache[ic_address[13:4]][64:49];			
			if(ic_address[3:1]==3'b100) 
				ic_read_output = inst_cache[ic_address[13:4]][80:65];			
			if(ic_address[3:1]==3'b101) 
				ic_read_output = inst_cache[ic_address[13:4]][96:81];			
			if(ic_address[3:1]==3'b110) 
				ic_read_output = inst_cache[ic_address[13:4]][112:97];			
			if(ic_address[3:1]==3'b111) 
				ic_read_output = inst_cache[ic_address[13:4]][128:113];
		
			ic_tag[ic_address[13:4]] = ic_address[15:14];
			ic_valid[ic_address[13:4]] = 1'b1;
			ic_dirty[ic_address[13:4]] = 1'b0;
		end


		if(ic_address[15:14]!=ic_tag[ic_address[13:4]] && (ic_enable==1'b0) && (ic_dirty[ic_address[13:4]]==1'b1)) begin	// read miss dirty(instruction cache)
			
			//$display("inst_cache, read miss dirty");

			ic_temp[10:1] = ic_address[13:4];
			ic_temp[12:11] = ic_tag[ic_address[13:4]];

			main_memory[ic_temp] = inst_cache[ic_address[13:4]];

			inst_cache[ic_address[13:4]]=main_memory[ic_address[15:4]];

			//$display("add = %b, read_out = %b", ic_address, inst_cache[ic_address[13:4]]);

			if(ic_address[3:1]==3'b000) 
				ic_read_output = inst_cache[ic_address[13:4]][16:1];			
			if(ic_address[3:1]==3'b001) 
				ic_read_output = inst_cache[ic_address[13:4]][32:17];			
			if(ic_address[3:1]==3'b010) 
				ic_read_output = inst_cache[ic_address[13:4]][48:33];			
			if(ic_address[3:1]==3'b011) 
				ic_read_output = inst_cache[ic_address[13:4]][64:49];			
			if(ic_address[3:1]==3'b100) 
				ic_read_output = inst_cache[ic_address[13:4]][80:65];			
			if(ic_address[3:1]==3'b101) 
				ic_read_output = inst_cache[ic_address[13:4]][96:81];			
			if(ic_address[3:1]==3'b110) 
				ic_read_output = inst_cache[ic_address[13:4]][112:97];			
			if(ic_address[3:1]==3'b111) 
				ic_read_output = inst_cache[ic_address[13:4]][128:113];			
		
			ic_tag[ic_address[13:4]] = ic_address[15:14];
			ic_valid[ic_address[13:4]] = 1'b1;
			ic_dirty[ic_address[13:4]] = 1'b0;
		end



		if(dc_write_address[15]==dc_tag[dc_write_address[14:4]] && dc_valid[dc_write_address[14:4]]==1'b1) begin	// write hit valid(data cache)
			
			//$display("data_cache, write hit valid");

			if(dc_write_address[3:1]==3'b000) 
				data_cache[dc_write_address[14:4]][16:1] = dc_write_data;			
			if(dc_write_address[3:1]==3'b001) 
				data_cache[dc_write_address[14:4]][32:17] = dc_write_data;			
			if(dc_write_address[3:1]==3'b010) 
				data_cache[dc_write_address[14:4]][48:33] = dc_write_data;			
			if(dc_write_address[3:1]==3'b011) 
				data_cache[dc_write_address[14:4]][64:49] = dc_write_data;			
			if(dc_write_address[3:1]==3'b100) 
				data_cache[dc_write_address[14:4]][80:65] = dc_write_data;			
			if(dc_write_address[3:1]==3'b101) 
				data_cache[dc_write_address[14:4]][96:81] = dc_write_data;			
			if(dc_write_address[3:1]==3'b110) 
				data_cache[dc_write_address[14:4]][112:97] = dc_write_data;			
			if(dc_write_address[3:1]==3'b111) 
				data_cache[dc_write_address[14:4]][128:113] = dc_write_data;			

			dc_dirty[dc_write_address[14:4]] = 1'b1;
		
			//$display("write_out = %b", data_cache[dc_write_address[14:4]]);

		end


		if(dc_write_address[15]==dc_tag[dc_write_address[14:4]] && dc_valid[dc_write_address[14:4]]==1'b0) begin	// write hit invalid(data cache)
			
			//$display("data_cache, write hit invalid");

			data_cache[dc_write_address[14:4]]=main_memory[dc_write_address[15:4]];

			if(dc_write_address[3:1]==3'b000) 
				data_cache[dc_write_address[14:4]][16:1] = dc_write_data;			
			if(dc_write_address[3:1]==3'b001) 
				data_cache[dc_write_address[14:4]][32:17] = dc_write_data;			
			if(dc_write_address[3:1]==3'b010) 
				data_cache[dc_write_address[14:4]][48:33] = dc_write_data;			
			if(dc_write_address[3:1]==3'b011) 
				data_cache[dc_write_address[14:4]][64:49] = dc_write_data;			
			if(dc_write_address[3:1]==3'b100) 
				data_cache[dc_write_address[14:4]][80:65] = dc_write_data;			
			if(dc_write_address[3:1]==3'b101) 
				data_cache[dc_write_address[14:4]][96:81] = dc_write_data;			
			if(dc_write_address[3:1]==3'b110) 
				data_cache[dc_write_address[14:4]][112:97] = dc_write_data;			
			if(dc_write_address[3:1]==3'b111) 
				data_cache[dc_write_address[14:4]][128:113] = dc_write_data;			

			dc_dirty[dc_write_address[14:4]] = 1'b1;
			dc_valid[dc_write_address[14:4]] = 1'b1;

			//$display("write_out = %b", data_cache[dc_write_address[14:4]]);

		end


		if(dc_write_address[15]!=dc_tag[dc_write_address[14:4]] && (dc_dirty[dc_write_address[14:4]]==1'b0)) begin	// write miss not dirty(data cache)
			
			//$display("data_cache, write miss not dirty");

			data_cache[dc_write_address[14:4]]=main_memory[dc_write_address[15:4]];

			if(dc_write_address[3:1]==3'b000) 
				data_cache[dc_write_address[14:4]][16:1] = dc_write_data;			
			if(dc_write_address[3:1]==3'b001) 
				data_cache[dc_write_address[14:4]][32:17] = dc_write_data;			
			if(dc_write_address[3:1]==3'b010) 
				data_cache[dc_write_address[14:4]][48:33] = dc_write_data;			
			if(dc_write_address[3:1]==3'b011) 
				data_cache[dc_write_address[14:4]][64:49] = dc_write_data;			
			if(dc_write_address[3:1]==3'b100) 
				data_cache[dc_write_address[14:4]][80:65] = dc_write_data;			
			if(dc_write_address[3:1]==3'b101) 
				data_cache[dc_write_address[14:4]][96:81] = dc_write_data;			
			if(dc_write_address[3:1]==3'b110) 
				data_cache[dc_write_address[14:4]][112:97] = dc_write_data;			
			if(dc_write_address[3:1]==3'b111) 
				data_cache[dc_write_address[14:4]][128:113] = dc_write_data;			

			dc_dirty[dc_write_address[14:4]] = 1'b1;
			dc_tag[dc_write_address[14:4]] = dc_write_address[15];
			dc_valid[dc_write_address[14:4]] = 1'b1;

			//$display("write_out = %b", data_cache[dc_write_address[14:4]]);

		end


		if(dc_write_address[15]!=dc_tag[dc_write_address[14:4]] && (dc_dirty[dc_write_address[14:4]]==1'b1)) begin	// write miss dirty(data cache)
			
			//$display("data_cache, write miss dirty");

			dc_temp[11:1] = dc_write_address[14:4];
			dc_temp[12] = dc_tag[dc_write_address[14:4]];

			main_memory[dc_temp] = data_cache[dc_write_address[14:4]];

			data_cache[dc_write_address[14:4]]=main_memory[dc_write_address[15:4]];

			if(dc_write_address[3:1]==3'b000) 
				data_cache[dc_write_address[14:4]][16:1] = dc_write_data;			
			if(dc_write_address[3:1]==3'b001) 
				data_cache[dc_write_address[14:4]][32:17] = dc_write_data;			
			if(dc_write_address[3:1]==3'b010) 
				data_cache[dc_write_address[14:4]][48:33] = dc_write_data;			
			if(dc_write_address[3:1]==3'b011) 
				data_cache[dc_write_address[14:4]][64:49] = dc_write_data;			
			if(dc_write_address[3:1]==3'b100) 
				data_cache[dc_write_address[14:4]][80:65] = dc_write_data;			
			if(dc_write_address[3:1]==3'b101) 
				data_cache[dc_write_address[14:4]][96:81] = dc_write_data;			
			if(dc_write_address[3:1]==3'b110) 
				data_cache[dc_write_address[14:4]][112:97] = dc_write_data;			
			if(dc_write_address[3:1]==3'b111) 
				data_cache[dc_write_address[14:4]][128:113] = dc_write_data;			

			dc_dirty[dc_write_address[14:4]] = 1'b1;
			dc_tag[dc_write_address[14:4]] = dc_write_address[15];
			dc_valid[dc_write_address[14:4]] = 1'b1;

			//$display("write_out = %b", data_cache[dc_write_address[14:4]]);

		end


		if(dc_read_address[15]==dc_tag[dc_read_address[14:4]] && (dc_valid[dc_read_address[14:4]]==1'b1)) begin	// read hit valid(data cache)
			
			//$display("data_cache, read hit valid");

			//$display("add = %b, read_out = %b", dc_read_address, data_cache[dc_read_address[14:4]]);

			if(dc_read_address[3:1]==3'b000) 
				dc_read_output = data_cache[dc_read_address[14:4]][16:1];			
			if(dc_read_address[3:1]==3'b001) 
				dc_read_output = data_cache[dc_read_address[14:4]][32:17];			
			if(dc_read_address[3:1]==3'b010) 
				dc_read_output = data_cache[dc_read_address[14:4]][48:33];			
			if(dc_read_address[3:1]==3'b011) 
				dc_read_output = data_cache[dc_read_address[14:4]][64:49];			
			if(dc_read_address[3:1]==3'b100) 
				dc_read_output = data_cache[dc_read_address[14:4]][80:65];			
			if(dc_read_address[3:1]==3'b101) 
				dc_read_output = data_cache[dc_read_address[14:4]][96:81];			
			if(dc_read_address[3:1]==3'b110) 
				dc_read_output = data_cache[dc_read_address[14:4]][112:97];			
			if(dc_read_address[3:1]==3'b111) 
				dc_read_output = data_cache[dc_read_address[14:4]][128:113];			
		end


		if(dc_read_address[15]==dc_tag[dc_read_address[14:4]] && (dc_valid[dc_read_address[14:4]]==1'b0)) begin	// read hit invalid(data cache)
			
			//$display("data_cache, read hit invalid");

			data_cache[dc_read_address[14:4]]=main_memory[dc_read_address[15:4]];

			//$display("add = %b, read_out = %b", dc_read_address, data_cache[dc_read_address[14:4]]);

			if(dc_read_address[3:1]==3'b000) 
				dc_read_output = data_cache[dc_read_address[14:4]][16:1];			
			if(dc_read_address[3:1]==3'b001) 
				dc_read_output = data_cache[dc_read_address[14:4]][32:17];			
			if(dc_read_address[3:1]==3'b010) 
				dc_read_output = data_cache[dc_read_address[14:4]][48:33];			
			if(dc_read_address[3:1]==3'b011) 
				dc_read_output = data_cache[dc_read_address[14:4]][64:49];			
			if(dc_read_address[3:1]==3'b100) 
				dc_read_output = data_cache[dc_read_address[14:4]][80:65];			
			if(dc_read_address[3:1]==3'b101) 
				dc_read_output = data_cache[dc_read_address[14:4]][96:81];			
			if(dc_read_address[3:1]==3'b110) 
				dc_read_output = data_cache[dc_read_address[14:4]][112:97];			
			if(dc_read_address[3:1]==3'b111) 
				dc_read_output = data_cache[dc_read_address[14:4]][128:113];			

			dc_valid[dc_read_address[14:4]] = 1'b1;
		end


		if(dc_read_address[15]!=dc_tag[dc_read_address[14:4]] && (dc_dirty[dc_read_address[14:4]]==1'b0)) begin	// read miss not dirty(data cache)

			//$display("data_cache, read miss not dirty");

			data_cache[dc_read_address[14:4]]=main_memory[dc_read_address[15:4]];

			//$display("add = %b, read_out = %b", dc_read_address, data_cache[dc_read_address[14:4]]);

			if(dc_read_address[3:1]==3'b000) 
				dc_read_output = data_cache[dc_read_address[14:4]][16:1];			
			if(dc_read_address[3:1]==3'b001) 
				dc_read_output = data_cache[dc_read_address[14:4]][32:17];			
			if(dc_read_address[3:1]==3'b010) 
				dc_read_output = data_cache[dc_read_address[14:4]][48:33];			
			if(dc_read_address[3:1]==3'b011) 
				dc_read_output = data_cache[dc_read_address[14:4]][64:49];			
			if(dc_read_address[3:1]==3'b100) 
				dc_read_output = data_cache[dc_read_address[14:4]][80:65];			
			if(dc_read_address[3:1]==3'b101) 
				dc_read_output = data_cache[dc_read_address[14:4]][96:81];			
			if(dc_read_address[3:1]==3'b110) 
				dc_read_output = data_cache[dc_read_address[14:4]][112:97];			
			if(dc_read_address[3:1]==3'b111) 
				dc_read_output = data_cache[dc_read_address[14:4]][128:113];			
		
			dc_tag[dc_read_address[14:4]] = dc_read_address[15];
			dc_valid[dc_read_address[14:4]] = 1'b1;
			dc_dirty[dc_read_address[14:4]] = 1'b0;
		end


		if(dc_read_address[15]!=dc_tag[dc_read_address[14:4]] && (dc_dirty[dc_read_address[14:4]]==1'b1)) begin	// read miss dirty(data cache)
			
			//$display("data_cache, read miss dirty");

			dc_temp[11:1] = dc_read_address[14:4];
			dc_temp[12] = dc_tag[dc_read_address[14:4]];

			main_memory[dc_temp] = data_cache[dc_read_address[14:4]];

			data_cache[dc_read_address[14:4]]=main_memory[dc_read_address[15:4]];

			//$display("add = %b, read_out = %b", dc_read_address, data_cache[dc_read_address[14:4]]);

			if(dc_read_address[3:1]==3'b000) 
				dc_read_output = data_cache[dc_read_address[14:4]][16:1];			
			if(dc_read_address[3:1]==3'b001) 
				dc_read_output = data_cache[dc_read_address[14:4]][32:17];			
			if(dc_read_address[3:1]==3'b010) 
				dc_read_output = data_cache[dc_read_address[14:4]][48:33];			
			if(dc_read_address[3:1]==3'b011) 
				dc_read_output = data_cache[dc_read_address[14:4]][64:49];			
			if(dc_read_address[3:1]==3'b100) 
				dc_read_output = data_cache[dc_read_address[14:4]][80:65];			
			if(dc_read_address[3:1]==3'b101) 
				dc_read_output = data_cache[dc_read_address[14:4]][96:81];			
			if(dc_read_address[3:1]==3'b110) 
				dc_read_output = data_cache[dc_read_address[14:4]][112:97];			
			if(dc_read_address[3:1]==3'b111) 
				dc_read_output = data_cache[dc_read_address[14:4]][128:113];
					
			dc_tag[dc_read_address[14:4]] = dc_read_address[15];
			dc_valid[dc_read_address[14:4]] = 1'b1;
			dc_dirty[dc_read_address[14:4]] = 1'b0;
		end
	
	end

endmodule