module testBench_FullAdder;

	reg[8:0]a, b;
	reg temp;
	
	wire[7:0] sum;
	wire cout, overflow;
	
	add8Bits fullAdder(a, b , cin, sum, cout);
	
	initial begin
		temp = 0;
		for(a = 0; a < 256; a = a + 1) begin 
			for(b = 0; b < 256; b = b + 1) begin 
			 #10; //delay
			 if({cout, sum} != a + b) begin
				$display("ERROR: a=%b b=%b sum=%b cout=%b", a, b, sum, cout);
				temp = 1;
			 end
			 if(a[7] == b[7] && a[7] != sum[7] && overflow != 1) begin
				$display("OVERFLOW ERROR: a=%b b=%b sum=%b cout=%b", a, b, sum, cout);
				temp = 1;
			 end
		end
	end
	if(temp != 1)
		$display("The results are correct");
	end
	
endmodule