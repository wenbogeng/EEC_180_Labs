module mac(inA, inB, macc_clear, clk, macc_out);

	input	signed	[7:0]		inA, inB;
	input 						macc_clear, clk;

	reg signed	[18:0]			out, Product;
	
	output reg signed	[18:0]	macc_out;

	
	initial begin
		macc_out = 0;
		out = 0;
	end 
	
	always @ (posedge clk) begin
		Product = inA * inB;
		if(macc_clear)
			macc_out <= Product;
		else
			macc_out <= macc_out + Product;
	end

endmodule

	
	
	
	
//	wire				[18:0]		stage_Multi, stage_Plus, stage_MUX, cout;
	
	
//	singed_Multi stage_comp1 (inA, inB, stage_Multi);
//	singed_Plus stage_comp2 (stage_Multi, out, stage_Plus, 0 , cout);
//	two_One_MUX stage_comp3(stage_Multi, stage_Plus, macc_clear, stage_MUX);
//	d_Latch stage_comp4(stage_MUX, clk, out);
	
//	
//endmodule