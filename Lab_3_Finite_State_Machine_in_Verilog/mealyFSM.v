module mealyFSM (clk, rst, x, z);

    input clk;
    input rst;
    input x;
    output reg z;
	 
	 reg [3:0] temp_z;
    reg [3:0] current_state, next_state;
	 
    parameter S0 = 3'b000;
	 parameter S1 = 3'b001;
	 parameter S2 = 3'b010;
	 parameter S3 = 3'b011;
	 parameter S4 = 3'b100;
	 parameter S5 = 3'b101;
	 parameter S6 = 3'b110;
	 parameter S7 = 3'b111;
	 
    always@(posedge clk or posedge rst) 
	 begin
		if(rst)
			begin
				current_state <= S0;
			end
      else 
			begin
            current_state <= next_state;
			end
    end
    
    always@(current_state, x) begin
        case(current_state)
            S0:begin
                if(x == 1)
						begin
							next_state = S1;
							z = 0;
						end
                else
						begin
							next_state = S3;
							z = 0;
						end
            end
            S1:begin
                if(x == 1)
						begin
                    next_state = S6;
						  z = 0;
						end
                else
						begin
                    next_state = S2;
						  z = 0;
						end
            end
            S2:begin
                if(x == 1)
						begin
                    next_state = S1;
						  z = 1;
						end
                else
						begin
                    next_state = S4;
						  z = 0;
						end
            end
            S3:begin
                if(x == 1)
						begin
                    next_state = S1;
						  z = 0;
						end
                else
						begin
                    next_state = S4;
						  z = 0;
						end
            end
            S4:begin
                if(x == 1)
						begin
                    next_state = S1;
						  z = 0;
						end
                else
						begin
                    next_state = S5;
						  z = 0;
						end
            end				
            S5:begin
					next_state = S5;
					z = 0;
            end				
            S6:begin
                if(x == 1)
						begin
                    next_state = S7;
						  z = 1;
						end
                else
						begin
                    next_state = S2;
						  z = 0;
						end
            end				
            S7:begin
                next_state = S7;
					 z = 1;
            end				
				
				default:begin 
					next_state = S0;
					z = 0;
				end
				
        endcase
    end
    
        
endmodule