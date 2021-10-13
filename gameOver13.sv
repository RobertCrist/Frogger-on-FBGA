module gameOver13(clk, reset, hit, pixels);
	input logic clk, reset, hit;
	output logic [15:0] pixels;
	
	logic next;
	
	enum {safe, gg} ps, ns;
	
	always_comb begin
		case(ps)
			safe: if(hit)	ns = gg;
					else 		ns = safe;
			gg: 				ns = gg;
		endcase
	end
	
	always_comb begin
		case(ps)
			safe:	pixels = 16'b0000000000000000;	
			gg: 	pixels = 16'b0110011011101001;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= safe;
		else
			ps <= ns;
	end
endmodule