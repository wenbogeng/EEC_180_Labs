module SpMV ( start, reset, clk, done, clock_count );
	input										start, reset, clk;
	output			[10:0]				clock_count;
	output 									done;

	parameter 								DATA_WIDTH = 8;
	parameter 								ADDR_WIDTH = 4;
	
	//reg and wire declarations
	reg 			[5:0]						address_v_3, address_v_2, address_v_1, address_v_0, address_col_3, address_col_2, address_col_1, address_col_0, address_b, address_c;
	wire			[(DATA_WIDTH - 1):0]	data_in_a, data_in_b, data_out_v_3, data_out_v_2, data_out_v_1, data_out_v_0, 
																			data_out_b_3, data_out_b_2, data_out_b_1, data_out_b_0, 
																			data_out_col_3, data_out_col_2, data_out_col_1, data_out_col_0;
	reg										write_enable_a, write_enable_b, write_enable_c , clear_mac;
	wire			[18:0]					mac_out_3, mac_out_2, mac_out_1, mac_out_0, buffer_out, data_out_c;
	reg			[10:0]					clock_count_in;
	
	//instantiation
	controlFSM																	control(start, reset, clk, clock_count_in, done, clock_count);
	dualPortRam 	#(8, 6, "V.txt")										ram_V_1(address_v_3, address_v_2, data_in_a, write_enable_a, write_enable_a, clk, data_out_v_3, data_out_v_2);
	dualPortRam 	#(8, 6, "V.txt")										ram_V_0(address_v_1, address_v_0, data_in_a, write_enable_a, write_enable_a, clk, data_out_v_1, data_out_v_0);
	dualPortRam 	#(4, 6, "COL_INDEX.txt")							ram_COL_1(address_col_3, address_col_2, data_in_a, write_enable_a, write_enable_a, clk, data_out_col_3, data_out_col_2);
	dualPortRam 	#(4, 6, "COL_INDEX.txt")							ram_COL_0(address_col_1, address_col_0, data_in_a, write_enable_a, write_enable_a, clk, data_out_col_1, data_out_col_0);
	//dualPortRam 	#(DATA_WIDTH, ADDR_WIDTH, "ROW_INDEX.txt")	ram_ROW(address_a_1, address_a_0, data_in_a, write_enable_a, write_enable_a, clk, data_out_a_1, data_out_a_0);
	dualPortRam 	#(8, 4, "B.txt")										ram_b_1(data_out_col_3, data_out_col_2, data_in_b, write_enable_b, write_enable_b, clk, data_out_b_3, data_out_b_2);
	dualPortRam 	#(8, 4, "B.txt")										ram_b_0(data_out_col_1, data_out_col_0, data_in_b, write_enable_b, write_enable_b, clk, data_out_b_1, data_out_b_0);
	MAC																			mac3(data_out_v_3, data_out_b_3, clear_mac, clk, mac_out_3);
	MAC																			mac2(data_out_v_2, data_out_b_2, clear_mac, clk, mac_out_2);
	MAC																			mac1(data_out_v_1, data_out_b_1, clear_mac, clk, mac_out_1);
	MAC																			mac0(data_out_v_0, data_out_b_0, clear_mac, clk, mac_out_0);
	fourBuffer																	macbuffer(mac_out_3, mac_out_2, mac_out_1, mac_out_0, clk, clock_count, buffer_out);
	singlePortRam	#(19, 4)													RAMOUTPUT(address_c, buffer_out, write_enable_c, clk, data_out_c);
	
	//address, clear, enable logics
	always @(clock_count)
	begin
		//logic for address of V
		address_v_3 = clock_count + 46;
		address_v_2 = clock_count + 30;
		address_v_1 = clock_count + 14;
		address_v_0 = clock_count - 2;
		
		//logic for address of ROW_COL
		address_col_3 = clock_count + 47;
		address_col_2 = clock_count + 31;
		address_col_1 = clock_count + 15;
		address_col_0 = clock_count - 1;
		
		clear_mac = (((clock_count - 3) % 4 == 0) & clock_count > 2);
		address_c = ((clock_count * 4) % 16) + ((clock_count - 8) / 4);
		write_enable_c = clock_count > 7;
		clock_count_in = clock_count;
	end

endmodule
	