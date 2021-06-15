module controlFSM( start, reset, clk, clock_count_in, done, clock_count_out );
	input 						start, reset, clk;
	input			[10:0]		clock_count_in;
	output reg					done;
	output reg	[10:0]		clock_count_out;
	
	reg			[1:0]			current_state, next_state;
	reg			[10:0]		tempclock;
	reg							tempdone;
	
	parameter					reset_state = 2'b00;
	parameter					increment_state = 2'b01;
	parameter					finished_state = 2'b10;
	
	//output logic
	always @ ( posedge clk )
	begin
		if (reset)
		begin
			current_state <= reset_state;
			clock_count_out <= 0;
			done <= 0;
		end
		else
		begin
			current_state <= next_state;
			clock_count_out <= tempclock;
			done <= tempdone;
		end
	end

	//next state logic
	always @(start, reset, clock_count_in)
	begin
		case ( current_state )
		
			reset_state:
			begin
				if ( start )
				begin
					next_state <= increment_state;
					tempdone <= 0;
					tempclock <= 1;
				end
				else
				begin
					next_state <= reset_state;
					tempdone <= 0;
					tempclock <= 0;
				end
			end
			
			increment_state:
			begin
				if (clock_count_in == 514)
				begin
					next_state <= finished_state;
					tempdone <= 1;
					tempclock <= clock_count_in;
				end
				else
				begin
					next_state <= increment_state;
					tempdone <= 0;
					tempclock <= clock_count_in + 1;
				end
			end
			
			finished_state:
			begin
				begin
					next_state <= finished_state;
					tempdone <= 1;
					tempclock <= clock_count_in;
				end
			end
		endcase
	end
endmodule
