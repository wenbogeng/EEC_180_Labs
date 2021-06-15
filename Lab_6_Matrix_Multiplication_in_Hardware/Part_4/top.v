module top ( start, reset, clk, done, clock_count );
	input										start, reset, clk;
	output			[10:0]				clock_count;
	output 									done;

	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 6;
	
	//reg and wire declarations
	reg 			[(ADDR_WIDTH - 1):0]	address_a_7, address_a_6, address_a_5, address_a_4, address_a_3, address_a_2, address_a_1, address_a_0, address_b, address_c;
	wire			[(DATA_WIDTH - 1):0]	data_in_a, data_in_b, data_out_a_7, data_out_a_6, data_out_a_5, data_out_a_4, data_out_a_3, data_out_a_2, data_out_a_1, data_out_a_0, data_out_b;
	reg										write_enable_a, write_enable_b, write_enable_c , clear_mac;
	wire			[18:0]					mac_out_7, mac_out_6, mac_out_5, mac_out_4, mac_out_3, mac_out_2, mac_out_1, mac_out_0, buffer_out, data_out_c;
	reg			[10:0]					clock_count_in;
	
	controlFSM																	control(start, reset, clk, clock_count_in, done, clock_count);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a76(address_a_7, address_a_6, data_in_a, write_enable_a, write_enable_a, clk, data_out_a_7, data_out_a_6);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a54(address_a_5, address_a_4, data_in_a, write_enable_a, write_enable_a, clk, data_out_a_5, data_out_a_4);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a32(address_a_3, address_a_2, data_in_a, write_enable_a, write_enable_a, clk, data_out_a_3, data_out_a_2);
	dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_a_init.txt")	ram_a01(address_a_1, address_a_0, data_in_a, write_enable_a, write_enable_a, clk, data_out_a_1, data_out_a_0);
	singlePortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ram_b_init.txt")	ram_b(address_b, data_in_b, write_enable_b, clk, data_out_b);
	MAC																			mac7(data_out_a_7, data_out_b, clear_mac, clk, mac_out_7);
	MAC																			mac6(data_out_a_6, data_out_b, clear_mac, clk, mac_out_6);
	MAC																			mac5(data_out_a_5, data_out_b, clear_mac, clk, mac_out_5);
	MAC																			mac4(data_out_a_4, data_out_b, clear_mac, clk, mac_out_4);
	MAC																			mac3(data_out_a_3, data_out_b, clear_mac, clk, mac_out_3);
	MAC																			mac2(data_out_a_2, data_out_b, clear_mac, clk, mac_out_2);
	MAC																			mac1(data_out_a_1, data_out_b, clear_mac, clk, mac_out_1);
	MAC																			mac0(data_out_a_0, data_out_b, clear_mac, clk, mac_out_0);
	eightBuffer																	macbuffer(mac_out_7, mac_out_6, mac_out_5, mac_out_4, mac_out_3, mac_out_2, mac_out_1, mac_out_0, clk, clock_count, buffer_out);
	singlePortRam	#(19, ADDR_WIDTH)										RAMOUTPUT(address_c, buffer_out, write_enable_c, clk, data_out_c);
	
	//address, clear, enable logics
	always @(clock_count)
	begin
		address_a_7 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 7;
		address_a_6 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 6;
		address_a_5 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 5;
		address_a_4 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 4;
		address_a_3 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 3;
		address_a_2 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 2;
		address_a_1 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64) + 1;
		address_a_0 = ((clock_count - 1) % 8) * 8 +  2 * ((clock_count - 1) / 64);
		address_b = ((clock_count - 1) % 64);
		clear_mac = (((clock_count - 2) % 8 == 0) & clock_count > 2) | clock_count == 2;
		address_c = clock_count - 11;
		write_enable_c = clock_count > 10;
		clock_count_in = clock_count;
	end

endmodule
	