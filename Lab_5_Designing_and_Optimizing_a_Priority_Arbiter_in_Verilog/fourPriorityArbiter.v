module fourPriorityArbiter(in3, in2, in1, in0, out);
	parameter						n = 8;
	
	input				[n-1:0]		in3, in2, in1, in0;
	output			[1:0]			out;
	
	wire				[n-1:0]		stage1_1c, stage1_0c, stage2_in1, stage2_in0;
	
	higherComparator	#(n)	stage1_comp1(in3, in2, stage1_1c);
	higherComparator	#(n)	stage1_comp0(in1, in0, stage1_0c);
	
	twoToOneMUX			#(n)	stage2_MUX1(in3, in2, stage1_1c, stage2_in1);
	twoToOneMUX			#(n)	stage2_MUX0(in1, in0, stage1_0c, stage2_in0);
	
	higherComparator	#(n)	stage2_comp0(stage2_in1, stage2_in0, out[1]);
	twoToOneMUX			#(n)	out0_MUX(stage1_1c, stage1_0c, out[1], out[0]);
	
endmodule