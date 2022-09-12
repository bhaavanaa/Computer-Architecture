module decoder(in, out);
	input [4:0] in;
	output [31:0] out;

	assign out[0]=~in[4]&~in[3]&~in[2]&~in[1]&~in[0];
	assign out[1]=~in[4]&~in[3]&~in[2]&~in[1]&in[0];
	assign out[2]=~in[4]&~in[3]&~in[2]&in[1]&~in[0];
	assign out[3]=~in[4]&~in[3]&~in[2]&in[1]&in[0];
	assign out[4]=~in[4]&~in[3]&in[2]&~in[1]&~in[0];
	assign out[5]=~in[4]&~in[3]&in[2]&~in[1]&in[0];
	assign out[6]=~in[4]&~in[3]&in[2]&in[1]&~in[0];
	assign out[7]=~in[4]&~in[3]&in[2]&in[1]&in[0];
	assign out[8]=~in[4]&in[3]&~in[2]&~in[1]&~in[0];
	assign out[9]=~in[4]&in[3]&~in[2]&~in[1]&in[0];
	assign out[10]=~in[4]&in[3]&~in[2]&in[1]&~in[0];
	assign out[11]=~in[4]&in[3]&~in[2]&in[1]&in[0];
	assign out[12]=~in[4]&in[3]&in[2]&~in[1]&~in[0];
	assign out[13]=~in[4]&in[3]&in[2]&~in[1]&in[0];
	assign out[14]=~in[4]&in[3]&in[2]&in[1]&~in[0];
	assign out[15]=~in[4]&in[3]&in[2]&in[1]&in[0];

	assign out[16]=in[4]&~in[3]&~in[2]&~in[1]&~in[0];
	assign out[17]=in[4]&~in[3]&~in[2]&~in[1]&in[0];
	assign out[18]=in[4]&~in[3]&~in[2]&in[1]&~in[0];
	assign out[19]=in[4]&~in[3]&~in[2]&in[1]&in[0];
	assign out[20]=in[4]&~in[3]&in[2]&~in[1]&~in[0];
	assign out[21]=in[4]&~in[3]&in[2]&~in[1]&in[0];
	assign out[22]=in[4]&~in[3]&in[2]&in[1]&~in[0];
	assign out[23]=in[4]&~in[3]&in[2]&in[1]&in[0];
	assign out[24]=in[4]&in[3]&~in[2]&~in[1]&~in[0];
	assign out[25]=in[4]&in[3]&~in[2]&~in[1]&in[0];
	assign out[26]=in[4]&in[3]&~in[2]&in[1]&~in[0];
	assign out[27]=in[4]&in[3]&~in[2]&in[1]&in[0];
	assign out[28]=in[4]&in[3]&in[2]&~in[1]&~in[0];
	assign out[29]=in[4]&in[3]&in[2]&~in[1]&in[0];
	assign out[30]=in[4]&in[3]&in[2]&in[1]&~in[0];
	assign out[31]=in[4]&in[3]&in[2]&in[1]&in[0];
	
endmodule
