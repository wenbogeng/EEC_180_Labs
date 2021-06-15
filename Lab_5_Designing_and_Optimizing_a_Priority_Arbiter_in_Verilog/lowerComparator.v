module lowerComparator(a, b, gt);
	parameter						n = 8;
	
	input			[n-1:0]			a;
	input			[n-1:0]			b;
	output wire						gt;
	
	assign gt = a > b;

endmodule
