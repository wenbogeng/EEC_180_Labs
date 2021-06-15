module singlePortRam(address, data_in, write_enable, clk, data_out);

	parameter 								DATA_WIDTH = 4;
	parameter 								ADDR_WIDTH = 4;
	
	input 		[(ADDR_WIDTH - 1):0]	address;
	input 		[(DATA_WIDTH - 1):0]	data_in;
	input										write_enable, clk;
	output reg 	[(DATA_WIDTH - 1):0]	data_out;

	//reg			[4:0]		 				i;
	
	reg [DATA_WIDTH - 1:0] ram[2**ADDR_WIDTH - 1:0]
	/* synthesis ramstyle = "M9K" */ ;
	
	always @ (posedge clk)
	begin
		if ( write_enable )
			ram[address] = data_in;
		data_out = ram[address];
	end
	
	/*
	initial
	begin
		for ( i = 0; i < 16; i = i + 1 )
			ram[i] = i[3:0];
	end
	*/	
	
	initial
	begin
		$readmemb("ram.txt", ram);
	end
	
endmodule
