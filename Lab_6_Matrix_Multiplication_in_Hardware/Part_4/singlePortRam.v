module singlePortRam(address, data_in, write_enable, clk, data_out);

	parameter 								DATA_WIDTH = 4;
	parameter 								ADDR_WIDTH = 4;
	parameter								INIT_FILE = "";
	
	input 		[(ADDR_WIDTH - 1):0]	address;
	input 		[(DATA_WIDTH - 1):0]	data_in;
	input										write_enable, clk;
	output reg 	[(DATA_WIDTH - 1):0]	data_out;
	
	reg signed [DATA_WIDTH - 1:0] mem[2**ADDR_WIDTH - 1:0]
	/* synthesis ramstyle = "M9K" */ ;
	
	always @ (posedge clk)
	begin
		if ( write_enable )
			mem[address] <= data_in;
		data_out <= mem[address];
	end
	
	initial
	begin
		if (INIT_FILE != "")
		begin
			$readmemb(INIT_FILE, mem);
		end
	end
	
endmodule
