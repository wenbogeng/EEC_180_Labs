module test_eightPA(in, out7, out6, out5, out4, out3, out2, out1, out0);
	parameter 					n = 8;
	input			[2:0]			in;
	output reg	[n-1:0]		out7, out6, out5, out4, out3, out2, out1, out0;
	
	integer						i, j;
	
	initial
	begin
		for ( i = 0; i < 100; i = i + 1)
		begin
			out7 = $urandom%2**n-1;
			out6 = $urandom%2**n-1;
			out5 = $urandom%2**n-1;
			out4 = $urandom%2**n-1;
			out3 = $urandom%2**n-1;
			out2 = $urandom%2**n-1;
			out1 = $urandom%2**n-1;
			out0 = $urandom%2**n-1;
			#20;
			
			if ( out7 > out6 && out7 > out5 && out7 > out4 && out7 > out3 && out7 > out2 && out7 > out1 && out7 > out0 )
				j = 7;
			else if ( out6 >= out7 && out6 > out5 && out6 > out4 && out6 > out3 && out6 > out2 && out6 > out1 && out6 > out0 )
				j = 6;
			else if ( out5 >= out7 && out5 >= out6 && out5 > out4 && out5 > out3 && out5 > out2 && out5 > out1 && out5 > out0 )
				j = 5;
			else if ( out4 >= out7 && out4 >= out6 && out4 >= out5 && out4 > out3 && out4 > out2 && out4 > out1 && out4 > out0 )
				j = 4;
			else if ( out3 >= out7 && out3 >= out6 && out3 >= out5 && out3 >= out4 && out3 > out2 && out3 > out1 && out3 > out0 )
				j = 3;
			else if ( out2 >= out7 && out2 >= out6 && out2 >= out5 && out2 >= out4 && out2 >= out3 && out2 > out1 && out2 > out0 )
				j = 2;
			else if ( out1 >= out7 && out1 >= out6 && out1 >= out5 && out1 >= out4 && out1 >= out3 && out1 >= out2 && out1 > out0 )
				j = 1;
			else if ( out0 >= out7 && out0 >= out6 && out0 >= out5 && out0 >= out4 && out0 >= out3 && out0 >= out2 && out0 >= out1 )
				j = 0;
			if ( in != j )
				$display ( "ERROR: result of %h, %h, %h, %h, %h, %h, %h, %h is %d, should be %d", out7, out6, out5, out4, out3, out2, out1, out0, in, j);
			#10;
		end
		out7 = 2**n-1;
		out6 = 2**n-1;
		out5 = 2**n-1;
		out4 = 2**n-1;
		out3 = 2**n-1;
		out2 = 2**n-1;
		out1 = 2**n-1;
		out0 = 2**n-1;
		#20;
		$display ( "TIEBREAK: result of %h, %h, %h, %h, %h, %h, %h, %h is %d, should be %d", out7, out6, out5, out4, out3, out2, out1, out0, in, 0);
	end
endmodule
