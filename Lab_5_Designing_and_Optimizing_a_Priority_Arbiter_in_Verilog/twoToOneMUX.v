module twoToOneMUX(in1, in0, s, out);
	parameter				n = 8;
	
	input			[n-1:0]			in1;
	input			[n-1:0]			in0;
	input								s;
	output wire	[n-1:0]			out;

	assign out = (in1 & {n{s}}) | (in0 & {n{~s}});

endmodule
