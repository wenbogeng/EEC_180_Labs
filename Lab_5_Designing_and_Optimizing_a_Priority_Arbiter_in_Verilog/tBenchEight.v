module tBenchEight;
	parameter					n = 8;
	wire		[n-1:0]			in7, in6, in5, in4, in3, in2, in1, in0;
	wire		[2:0]				out;
	
	eightPriorityArbiter #(n)	ePA(in7, in6, in5, in4, in3, in2, in1, in0, out);
	test_eightPA			#(n)	tEPA(out, in7, in6, in5, in4, in3, in2, in1, in0);
	
endmodule