module testMealyFSM;
	reg 	clk, rst, X;

	mealyFSM	mFSM(clk, rst, X, Z);
	
	
	//initialize clock, period = 10
	initial
		forever
			begin
				#5 clk = 1;	
				$display("%b, %b, %b, %b",
							rst, X, mFSM.current_state, mFSM.z);
				#5 clk = 0;
			end
			
	//inputs
	initial begin
		#10	rst = 0;
		#20	rst = 1;	X = 0;
		#10	rst = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 0;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 1;
		#10 	X = 1;
		#10 	X = 1;
		#10 	rst = 1;	X = 0;
		#10	rst = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 1;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 1;
		#10 	X = 0;
		#10 	X = 0;
		#10 	X = 0;
		#10
		$finish;
	end
endmodule
