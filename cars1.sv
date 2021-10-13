module cars1(clk, reset, hit, pixels);
	input logic clk, reset, hit;
	output logic [15:0] pixels;
	
	logic next;
	
	enum {pos0, pos1, pos2, gg} ps, ns;
	
	upCounter up(.clk, .reset, .out(next));
	defparam up.WIDTH = 10;
	
	always_comb begin
		case(ps)
			pos0:	if(next)			ns = pos1;
					else if(hit)	ns = gg;
					else 				ns = pos0;
			pos1:	if(next)			ns = pos2;
					else if(hit)	ns = gg;
					else 				ns = pos1;
			pos2:	if(next)			ns = pos0;
					else if(hit)	ns = gg;
					else 				ns = pos2;
			gg:						ns = gg;
		endcase
	end
	
	always_comb begin
		case(ps)
			pos0:	pixels = 16'b1101101101101101;
			pos1:	pixels = 16'b0110110110110110;
			pos2:	pixels = 16'b1011011011011011;
			gg: 	pixels = 16'b0000000000000000;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= pos1;
		else
			ps <= ns;
	end
endmodule