module eightBuffer(mac_in_7, mac_in_6, mac_in_5, mac_in_4, mac_in_3, mac_in_2, mac_in_1, mac_in_0, clk, clock_count, out);
	input				[18:0]			mac_in_7, mac_in_6, mac_in_5, mac_in_4, mac_in_3, mac_in_2, mac_in_1, mac_in_0;
	input				[10:0]			clock_count;
	input									clk;
	output reg		[18:0]			out;
	
	wire				[18:0]			ff_7_6_out, ff_7_5_out, ff_7_4_out, ff_7_3_out, ff_7_2_out, ff_7_1_out, ff_7_0_out, 
											ff_6_5_out, ff_6_4_out, ff_6_3_out, ff_6_2_out, ff_6_1_out, ff_6_0_out, 
											ff_5_4_out, ff_5_3_out, ff_5_2_out, ff_5_1_out, ff_5_0_out, 
											ff_4_3_out, ff_4_2_out, ff_4_1_out, ff_4_0_out, 
											ff_3_2_out, ff_3_1_out, ff_3_0_out, 
											ff_2_1_out, ff_2_0_out, 
											ff_1_0_out;
	
	dff	#(19)		bufferdff_7_6(mac_in_7, clk, ff_7_6_out);
	dff	#(19)		bufferdff_7_5(ff_7_6_out, clk, ff_7_5_out);
	dff	#(19)		bufferdff_7_4(ff_7_5_out, clk, ff_7_4_out);
	dff	#(19)		bufferdff_7_3(ff_7_4_out, clk, ff_7_3_out);
	dff	#(19)		bufferdff_7_2(ff_7_3_out, clk, ff_7_2_out);
	dff	#(19)		bufferdff_7_1(ff_7_2_out, clk, ff_7_1_out);
	dff	#(19)		bufferdff_7_0(ff_7_1_out, clk, ff_7_0_out);
	dff	#(19)		bufferdff_6_5(mac_in_6, clk, ff_6_5_out);
	dff	#(19)		bufferdff_6_4(ff_6_5_out, clk, ff_6_4_out);
	dff	#(19)		bufferdff_6_3(ff_6_4_out, clk, ff_6_3_out);
	dff	#(19)		bufferdff_6_2(ff_6_3_out, clk, ff_6_2_out);
	dff	#(19)		bufferdff_6_1(ff_6_2_out, clk, ff_6_1_out);
	dff	#(19)		bufferdff_6_0(ff_6_1_out, clk, ff_6_0_out);
	dff	#(19)		bufferdff_5_4(mac_in_5, clk, ff_5_4_out);
	dff	#(19)		bufferdff_5_3(ff_5_4_out, clk, ff_5_3_out);
	dff	#(19)		bufferdff_5_2(ff_5_3_out, clk, ff_5_2_out);
	dff	#(19)		bufferdff_5_1(ff_5_2_out, clk, ff_5_1_out);
	dff	#(19)		bufferdff_5_0(ff_5_1_out, clk, ff_5_0_out);
	dff	#(19)		bufferdff_4_3(mac_in_4, clk, ff_4_3_out);
	dff	#(19)		bufferdff_4_2(ff_4_3_out, clk, ff_4_2_out);
	dff	#(19)		bufferdff_4_1(ff_4_2_out, clk, ff_4_1_out);
	dff	#(19)		bufferdff_4_0(ff_4_1_out, clk, ff_4_0_out);
	dff	#(19)		bufferdff_3_2(mac_in_3, clk, ff_3_2_out);
	dff	#(19)		bufferdff_3_1(ff_3_2_out, clk, ff_3_1_out);
	dff	#(19)		bufferdff_3_0(ff_3_1_out, clk, ff_3_0_out);
	dff	#(19)		bufferdff_2_1(mac_in_2, clk, ff_2_1_out);
	dff	#(19)		bufferdff_2_0(ff_2_1_out, clk, ff_2_0_out);
	dff	#(19)		bufferdff_1_0(mac_in_1, clk, ff_1_0_out);
	
	always @(posedge clk)
	begin
		if (((clock_count - 2) % 8 == 0) & clock_count > 2)
		begin
			out = mac_in_0;
		end
		else if (((clock_count - 3) % 8 == 0) & clock_count > 2)
		begin
			out = ff_1_0_out;
		end
		else if (((clock_count - 4) % 8 == 0) & clock_count > 2)
		begin
			out = ff_2_0_out;
		end
		else if (((clock_count - 5) % 8 == 0) & clock_count > 2)
		begin
			out = ff_3_0_out;
		end
		else if (((clock_count - 6) % 8 == 0) & clock_count > 2)
		begin
			out = ff_4_0_out;
		end
		else if (((clock_count - 7) % 8 == 0) & clock_count > 2)
		begin
			out = ff_5_0_out;
		end
		else if (((clock_count - 0) % 8 == 0) & clock_count > 2)
		begin
			out = ff_6_0_out;
		end
		else if (((clock_count - 1) % 8 == 0) & clock_count > 2)
		begin
			out = ff_7_0_out;
		end
	end
endmodule

	