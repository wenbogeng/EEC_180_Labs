module test_fourPA(in, out3, out2, out1, out0);
	parameter 					n = 8;
	input			[1:0]			in;
	output reg	[n-1:0]		out3, out2, out1, out0;
	
	integer						i, j;
	
	initial
	begin
		for ( i = 0; i < 100; i = i + 1)
		begin
			out3 = $urandom%2**n-1;
			out2 = $urandom%2**n-1;
			out1 = $urandom%2**n-1;
			out0 = $urandom%2**n-1;
			#20;
			
			if ( out3 >= out2 && out3 >= out1 && out3 >= out0 )
				j = 3;
			else if ( out2 > out3 && out2 >= out1 && out2 >= out0 )
				j = 2;
			else if ( out1 > out3 && out1 > out2 && out1 >= out0 )
				j = 1;
			else if ( out0 > out3 && out0 > out2 && out0 > out1 )
				j = 0;
			if ( in != j )
				$display ( "ERROR: result of %h, %h, %h, %h is %d, should be %d", out3, out2, out1, out0, in, j);
			#10;
		end
		out3 = 2**n-1;
		out2 = 2**n-1;
		out1 = 2**n-1;
		out0 = 2**n-1;
		#20;
		$display ( "TIEBREAK: result of %h, %h, %h, %h is %d, should be %d", out3, out2, out1, out0, in, 3);
	end
endmodule
