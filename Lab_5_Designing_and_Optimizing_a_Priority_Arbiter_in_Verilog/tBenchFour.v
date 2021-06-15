module tBenchFour;
	parameter					n = 16;
	wire		[n-1:0]			in3, in2, in1, in0;
	wire		[1:0]				out;
	
	fourPriorityArbiter 	#(n)	fPA(in3, in2, in1, in0, out);
	test_fourPA				#(n)	tfPA(out, in3, in2, in1, in0);
	
endmodule