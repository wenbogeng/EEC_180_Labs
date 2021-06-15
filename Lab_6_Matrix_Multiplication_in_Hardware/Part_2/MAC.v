module MAC(a, b, macc_clear, clk, out);
	input signed 		[7:0]				a, b;
	input										macc_clear, clk;
	output reg signed	[18:0]			out;
	
	always @ (posedge clk)
	begin
		if (~macc_clear)
		begin
			out <= out + a * b;
		end
		else
		begin
			out <= a * b;
		end
	end
endmodule

		