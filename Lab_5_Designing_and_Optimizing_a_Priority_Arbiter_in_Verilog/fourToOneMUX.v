module fourToOneMUX(in3, in2, in1, in0, s, out);
	parameter				n = 8;
	
	input			[n-1:0]			in3, in2, in1, in0;
	input			[1:0]				s;
	output wire	[n-1:0]			out;

	assign out = (in3 & {n{s == 2'b11}}) | (in2 & {n{s == 2'b10}})
					| (in1 & {n{s == 2'b01}}) | (in0 & {n{s == 2'b00}});

endmodule
