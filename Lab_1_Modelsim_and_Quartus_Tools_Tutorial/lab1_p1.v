
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module LAB1(

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
	

);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================

// Turn off 7 -Segment Display:
assign HEX0 = 8'b11111111;

assign HEX1 = 8'b11111111;

assign HEX2 = 8'b11111111;

assign HEX3 = 8'b11111111;

assign HEX4 = 8'b11111111;

assign HEX5 = 8'b11111111;

//AND gate 
assign LEDR[0] = SW[0] & SW[1];

//OR gate 
assign LEDR[1] = SW[0] | SW[1];

//XOR gate 
assign LEDR[2] = SW[0] ^ SW[1];

//NAND gate 
assign LEDR[3] = ~(SW[0] & SW[1]);

//NOR gate 
assign LEDR[4] = ~(SW[0] | SW[1]);


endmodule
