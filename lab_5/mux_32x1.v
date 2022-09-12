module mux_32x1(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31, sel, out);

	input [15:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31;
	input [4:0] sel;

	output [15:0] out;

	assign out={16{!sel[4]&!sel[3]&!sel[2]&!sel[1]&!sel[0]}}&i0 |
					{16{!sel[4]&!sel[3]&!sel[2]&!sel[1]&sel[0]}}&i1 |
					{16{!sel[4]&!sel[3]&!sel[2]&sel[1]&!sel[0]}}&i2 |  
					{16{!sel[4]&!sel[3]&!sel[2]&sel[1]&sel[0]}}&i3 |
					{16{!sel[4]&!sel[3]&sel[2]&!sel[1]&!sel[0]}}&i4 |
					{16{!sel[4]&!sel[3]&sel[2]&!sel[1]&sel[0]}}&i5 |
					{16{!sel[4]&!sel[3]&sel[2]&sel[1]&!sel[0]}}&i6 |
					{16{!sel[4]&!sel[3]&sel[2]&sel[1]&sel[0]}}&i7 |
					{16{!sel[4]&sel[3]&!sel[2]&!sel[1]&!sel[0]}}&i8 |
					{16{!sel[4]&sel[3]&!sel[2]&!sel[1]&sel[0]}}&i9 |
					{16{!sel[4]&sel[3]&!sel[2]&sel[1]&!sel[0]}}&i10 |
					{16{!sel[4]&sel[3]&!sel[2]&sel[1]&sel[0]}}&i11 |
					{16{!sel[4]&sel[3]&sel[2]&!sel[1]&!sel[0]}}&i12 |
					{16{!sel[4]&sel[3]&sel[2]&!sel[1]&sel[0]}}&i13 |
					{16{!sel[4]&sel[3]&sel[2]&sel[1]&!sel[0]}}&i14 |
					{16{!sel[4]&sel[3]&sel[2]&sel[1]&sel[0]}}&i15 |

					{16{sel[4]&!sel[3]&!sel[2]&!sel[1]&!sel[0]}}&i16 |
					{16{sel[4]&!sel[3]&!sel[2]&!sel[1]&sel[0]}}&i17 |
					{16{sel[4]&!sel[3]&!sel[2]&sel[1]&!sel[0]}}&i18 |  
					{16{sel[4]&!sel[3]&!sel[2]&sel[1]&sel[0]}}&i19 |
					{16{sel[4]&!sel[3]&sel[2]&!sel[1]&!sel[0]}}&i20 |
					{16{sel[4]&!sel[3]&sel[2]&!sel[1]&sel[0]}}&i21 |
					{16{sel[4]&!sel[3]&sel[2]&sel[1]&!sel[0]}}&i22 |
					{16{sel[4]&!sel[3]&sel[2]&sel[1]&sel[0]}}&i23 |
					{16{sel[4]&sel[3]&!sel[2]&!sel[1]&!sel[0]}}&i24 |
					{16{sel[4]&sel[3]&!sel[2]&!sel[1]&sel[0]}}&i25 |
					{16{sel[4]&sel[3]&!sel[2]&sel[1]&!sel[0]}}&i26 |
					{16{sel[4]&sel[3]&!sel[2]&sel[1]&sel[0]}}&i27 |
					{16{sel[4]&sel[3]&sel[2]&!sel[1]&!sel[0]}}&i28 |
					{16{sel[4]&sel[3]&sel[2]&!sel[1]&sel[0]}}&i29 |
					{16{sel[4]&sel[3]&sel[2]&sel[1]&!sel[0]}}&i30 |
					{16{sel[4]&sel[3]&sel[2]&sel[1]&sel[0]}}&i31;

			
endmodule