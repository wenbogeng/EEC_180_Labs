module booth #(parameter n = 8)
(
	input Clock,
	input Resetn,
	input Start,
	input [n - 1:0] Mplier,
	input [n - 1:0] Mcand,
	
	output reg Done,
	output reg [2*n - 1:0] Product 
);
	
	// state transistors
	parameter S1 = 2'b00,
				 ADD = 2'b01,
				 SHIFT = 2'b11,
				 ADD2S = 2'b10;
	
	reg [1:0] current_Start_State, next_state; 
	reg [2*n + 1:0] a_reg, s_reg, p_reg, sum_reg;
	
	reg [n - 1:0] count; // intager i 
	wire [n:0] multiplier_neg; // nagative value of multiplier 
	
	always@(posedge Clock or negedge Resetn)
		if(!Resetn) current_Start_State = S1;
		else current_Start_State <= next_state; 
	
	always @(*) begin
		next_state = 2'bx;
		case (current_Start_State)
		S1  : if (Start) next_state = ADD;
				  else    next_state = S1;
		
		ADD   : next_state = SHIFT;
		SHIFT : if (count == n) next_state = ADD2S;
				  else            next_state = ADD;
		
		ADD2S : next_state = S1;
		endcase
		end
		
		// negative value of multiplier.
		assign multiplier_neg = -{Mplier[n-1],Mplier}; 
		
		always @(posedge Clock or negedge Resetn) begin
		if (!Resetn) begin
		{a_reg,s_reg,p_reg,count,Done,sum_reg, Product} <= 0;
		
		end else begin
		case (current_Start_State)
		
			S1 :  begin
			a_reg    <= {Mplier[n-1],Mplier,{(n+1){1'b0}}};
			s_reg    <= {multiplier_neg,{(n+1){1'b0}}};
			p_reg    <= {{(n+1){1'b0}},Mcand,1'b0}; 
			count <= 0;
			Done     <= 1'b0;

		end
		
		ADD  :  begin
      case (p_reg[1:0])
        2'b01       : sum_reg <= p_reg + a_reg; // postive 
        2'b10       : sum_reg <= p_reg + s_reg;  // negative 
        2'b00,2'b11 : sum_reg <= p_reg;       
      endcase
      
		count <= count + 1;
		
		end
		
		SHIFT :  begin
			p_reg <= {sum_reg[2*n+1],sum_reg[2*n+1:1]}; // right shift 
		
		end
		
		ADD2S : begin
			Product <= p_reg[2*n:1];
			Done <= 1'b1;
    end
  endcase
 end
end

endmodule