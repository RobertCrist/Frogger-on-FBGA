module frogLightsStart (clk, reset, L, R, U, D, NL, NR, NU, ND, hit, lightOn);
	input logic 		clk, reset;
	input logic  		L, R, U, D, NL, NR, NU, ND, hit;
	output logic 		lightOn;
	
	enum {off, on} ps, ns;

	always_comb begin
		case (ps)
			off: 	if ((L & NR) | (R & NL) | (D & NU) | (U & ND))	ns = on;
					else 															ns = off;
			on: 	if (L | R | U) 											ns = off;
					else 														 	ns = on;				
		endcase
	end
	
	always_comb begin
		case (ps)
			on: 	lightOn = 1'b1;
			off:  lightOn = 1'b0;				
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= on;
		else if(hit)
			ps <= off;
		else
			ps <= ns;
	end
endmodule