module eightPriorityArbiter(in7, in6, in5, in4, in3, in2, in1, in0, out);
	parameter							n = 8;
	
	input			[n-1:0]				in7, in6, in5, in4, in3, in2, in1, in0;
	output		[2:0]					out;
	
	wire			[n-1:0]				mux3out, mux2out, mux1out, mux0out;
	wire									comp3out, comp2out, comp1out, comp0out;
	
	lowerComparator	#(n)		comp3(in7, in6, comp3out);
	twoToOneMUX			#(n)		MUX3(in7, in6, comp3out, mux3out);
	lowerComparator	#(n)		comp2(in5, in4, comp2out);
	twoToOneMUX			#(n)		MUX2(in5, in4, comp2out, mux2out);
	lowerComparator	#(n)		comp1(in3, in2, comp1out);
	twoToOneMUX			#(n)		MUX1(in3, in2, comp1out, mux1out);
	lowerComparator	#(n)		comp0(in1, in0, comp0out);
	twoToOneMUX			#(n)		MUX0(in1, in0, comp0out, mux0out);
	
	fourLowerPriorityArbiter #(n) PA(mux3out, mux2out, mux1out, mux0out, out[2:1]);
	fourToOneMUX		#(n)		fourMUX(comp3out, comp2out, comp1out, comp0out, out[2:1], out[0]);

	
endmodule
