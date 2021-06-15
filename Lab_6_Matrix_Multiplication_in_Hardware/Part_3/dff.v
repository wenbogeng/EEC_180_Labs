module dff(D, clk, Q);
	parameter 					n = 19;
	input 		[n-1:0]		D;
	input							clk;
	output reg	[n-1:0]		Q;
	
	always @ (posedge clk)
	begin
		Q <= D;
	end
endmodule
