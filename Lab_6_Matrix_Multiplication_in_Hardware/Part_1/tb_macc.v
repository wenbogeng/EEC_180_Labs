`timescale 1ns/10ps

// Test bench module
module tb_macc;

// Input Array
/////////////////////////////////////////////////////////
//                  Test Bench Signals                 //
/////////////////////////////////////////////////////////

reg clk;

/////////////////////////////////////////////////////////
//                  I/O Declarations                   //
/////////////////////////////////////////////////////////
// declare variables to hold signals going into submodule
reg signed [7:0] inA, inB;
reg macc_clear;
reg signed [18:0] out;
// Output Signals
wire signed [18:0] macc_out;


/////////////////////////////////////////////////////////
//              Submodule Instantiation                //
/////////////////////////////////////////////////////////

/*****************************************
RENAME SIGNALS TO MATCH YOUR MODULE
******************************************/
mac DUT
(
    .clk        (clk),
    .macc_clear (macc_clear),
    .inA        (inA),
    .inB        (inB),
    .macc_out    (macc_out)
  );

integer i;
initial begin
    // YOUR CODE GOES HERE
	 clk = 0;
	 inA = 0;
	 inB = 0;
	 macc_clear = 1;

	 out = 0;
	 
	 #20
	 macc_clear = 0;
	 #20

	 for ( i = 0; i < 5; i = i + 1) begin
	 //		clk = 1;
//		macc_clear = 0; 
//
		inA = $urandom();
		inB = $urandom();
		
		out = out + (inA * inB);
		#10;
		
		if (macc_out != out)
			$display("ERROR: a=%d  b=%d  out=%d", inA, inB, macc_out);
		else
			$display("a=%d  b=%d  out=%d", inA, inB, macc_out);
    end

//		$display ( "RESULT: %b, %b, %b", inA, inB, macc_out);
//		@(posedge clk);
	 inA = 0;
	 inB = 0;
	 
	 macc_clear = 1;
	 out = 0;
	 
	 #20
	 macc_clear = 0;
	 #20
	 
	 for (i = 0; i < 5; i = i + 1) begin
	 
		inA = $random;
		inB = $random;
		out = out + (inA * inB);
		#20;
		if (macc_out != out)
			$display("ERROR: a=%d  b=%d  out=%d", inA, inB, macc_out);
		else
			$display("a=%d  b=%d  out=%d", inA, inB, macc_out);
		
	end 
	 
    $stop; // End Simulation
end


// Clock
always begin
   #10;           // wait for initial block to initialize clock
   clk = ~clk;
end

endmodule
