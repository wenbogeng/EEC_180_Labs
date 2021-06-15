module buffer(mac_in_1, mac_in_0, clk, clock_count, out);
	input				[18:0]			mac_in_1, mac_in_0;
	input				[10:0]			clock_count;
	input									clk;
	output reg		[18:0]			out;
	
	wire				[18:0]			buffered_out;
	
	dff	#(19)		bufferdff(mac_in_0, clk, buffered_out);
	
	always @(posedge clk)
	begin
		if (((clock_count - 2) % 8 == 0) & clock_count > 2)
		begin
			out = mac_in_1;
		end
		else if (((clock_count - 3) % 8 == 0) & clock_count > 2)
		begin
			out = buffered_out;
		end
	end
endmodule

	