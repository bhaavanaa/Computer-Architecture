`include "register_file1.v"

module top;

reg [5:1] read1, read2, write;
reg [16:1] data;
reg wen;
wire [16:1] out_read1, out_read2;

register_file r (read1, read2, write, data, wen, out_read1, out_read2);


initial
begin
    data=16'b0010101010101011; write=5'b00010; wen=1'b1; read1=5'b00010; read2=5'b00011;
    #100 data=16'b1111101010111011; write=5'b00101; wen=1'b1; read1=5'b00010; read2=5'b00101;
    //#100 data=16'b1111111111111111; write=5'b00010; 
 
end

endmodule