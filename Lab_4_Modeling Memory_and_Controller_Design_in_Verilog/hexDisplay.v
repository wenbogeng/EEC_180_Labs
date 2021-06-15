module hexDisplay(value, display);
	input 	[3:0]		value;
	output 	[7:0]		display;
	
	assign display[0] = (value[2] & ~value[1] & ~value[0]) | (value[3] & value[2] & ~value[1]) | (~value[3] & ~value[2] & ~value[1] & value[0]) | (value[3] & ~value[2] & value[1] & value[0]);
	assign display[1] = (value[2] & value[1] & ~value[0]) | (value[3] & value[1] & value[0]) | (value[3] & value[2] & ~value[0]) | (~value[3] & value[2] & ~value[1] & value[0]);
	assign display[2] = (value[3] & value[2] & ~value[0]) | (value[3] & value[2] & value[1]) | (~value[3] & ~value[2] & value[1] & ~value[0]);
	assign display[3] = (~value[2] & ~value[1] & value[0]) | (value[2] & value[1] & value[0]) | (~value[3] & value[2] & ~value[1] & ~value[0]) | (value[3] & ~value[2] & value[1] & ~value[0]);
	assign display[4] = (~value[3] & value[0]) | (~value[2] & ~value[1] & value[0]) | (~value[3] & value[2] & ~value[1]);
	assign display[5] = (~value[3] & ~value[2] & value[0]) | (~value[3] & ~value[2] & value[1]) | (~value[3] & value[1] & value[0]) | (value[3] & value[2] & ~value[1]);
	assign display[6] = (~value[3] & ~value[2] & ~value[1]) | (~value[3] & value[2] & value[1] & value[0]);
	assign display[7] = 1;
endmodule
