module top ( start, reset, clk, done, clock_count );
	input										start, reset, clk;
	output			[10:0]				clock_count;
	output 									done;

	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 6;
	
	//reg and wire declarations
	reg 			[(ADDR_WIDTH - 1):0]	address_a, address_b, address_c;
	wire			[(DATA_WIDTH - 1):0]	data_in_a, data_in_b, data_out_a, data_out_b;
	reg										write_enable_a, write_enable_b, write_enable_c , clear_mac;
	wire			[18:0]					mac_out, data_out_c;
	reg			[10:0]					clock_count_in;
	
	//instantiation
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a(address_a, data_in_a, write_enable_a, clk, data_out_a);
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_b_init.txt")	ram_b(address_b, data_in_b, write_enable_b, clk, data_out_b);
	MAC																			mac(data_out_a, data_out_b, clear_mac, clk, mac_out);
	singlePortRam	#(19, ADDR_WIDTH)										RAMOUTPUT(address_c, mac_out, write_enable_c, clk, data_out_c);
	controlFSM																	control(start, reset, clk, clock_count_in, done, clock_count);

	//address, clear, enable logics
	always @(clock_count)
	begin
		clock_count_in = clock_count;
		address_a = ((clock_count - 1) % 8) * 8 +  ((clock_count - 1) / 64);
		address_b = ((clock_count - 1) % 64);
		clear_mac = (((clock_count - 2) % 8 == 0) & clock_count > 2) | reset;
		address_c = ((((clock_count - 3) / 8) * 8) % 64) + (clock_count - 3)/64;
		write_enable_c = clear_mac;
	end
	
endmodule
	