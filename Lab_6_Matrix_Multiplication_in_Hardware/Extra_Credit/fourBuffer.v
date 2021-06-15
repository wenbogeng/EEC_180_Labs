module fourBuffer(mac_in_3, mac_in_2, mac_in_1, mac_in_0, clk, clock_count, out);
	input				[18:0]			mac_in_3, mac_in_2, mac_in_1, mac_in_0;
	input				[10:0]			clock_count;
	input									clk;
	output reg		[18:0]			out;
	
	wire				[18:0]			ff_3_2_out, ff_3_1_out, ff_3_0_out, 
											ff_2_1_out, ff_2_0_out, 
											ff_1_0_out;
	
	dff	#(19)		bufferdff_3_2(mac_in_3, clk, ff_3_2_out);
	dff	#(19)		bufferdff_3_1(ff_3_2_out, clk, ff_3_1_out);
	dff	#(19)		bufferdff_3_0(ff_3_1_out, clk, ff_3_0_out);
	dff	#(19)		bufferdff_2_1(mac_in_2, clk, ff_2_1_out);
	dff	#(19)		bufferdff_2_0(ff_2_1_out, clk, ff_2_0_out);
	dff	#(19)		bufferdff_1_0(mac_in_1, clk, ff_1_0_out);
	
	always @(posedge clk)
	begin
		if (((clock_count - 3) % 4 == 0) & clock_count > 2)
		begin
			out = mac_in_0;
		end
		else if (((clock_count - 4) % 4 == 0) & clock_count > 2)
		begin
			out = ff_1_0_out;
		end
		else if (((clock_count - 5) % 4 == 0) & clock_count > 2)
		begin
			out = ff_2_0_out;
		end
		else if (((clock_count - 6) % 4 == 0) & clock_count > 2)
		begin
			out = ff_3_0_out;
		end
	end
endmodule

	