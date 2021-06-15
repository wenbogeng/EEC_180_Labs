module dualPortRam(address_1, address_0, data_in, write_enable_1, write_enable_0, clk, data_out_1, data_out_0);

	parameter 								DATA_WIDTH = 4;
	parameter 								ADDR_WIDTH = 4;
	parameter								INIT_FILE = "";
	
	input 		[(ADDR_WIDTH - 1):0]	address_1, address_0;
	input 		[(DATA_WIDTH - 1):0]	data_in;
	input										write_enable_1, write_enable_0, clk;
	output reg 	[(DATA_WIDTH - 1):0]	data_out_1, data_out_0;

	reg signed [DATA_WIDTH - 1:0] mem[2**ADDR_WIDTH - 1:0]
	/* synthesis ramstyle = "M9K" */;
	
	always @ (posedge clk)
	begin
		if ( write_enable_1 )
		begin
			mem[address_1] <= data_in;
		end
		data_out_1 <= mem[address_1];
		
		if ( write_enable_0 )
		begin
			mem[address_1] <= data_in;
		end
		data_out_0 <= mem[address_0];
	end
	
	initial
	begin
		if (INIT_FILE != "")
		begin
			$readmemb(INIT_FILE, mem);
		end
	end
	
endmodule
