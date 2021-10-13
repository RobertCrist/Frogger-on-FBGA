module cars12(clk, reset, hit, pixels);
	input logic clk, reset, hit;
	output logic [15:0] pixels;
	
	logic next;
	
	enum {pos0, pos1, pos2, pos3, pos4, gg} ps, ns;
	
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
			pos2:	if(next)			ns = pos3;
					else if(hit)	ns = gg;
					else 				ns = pos2;
			pos3:	if(next)			ns = pos4;
					else if(hit)	ns = gg;
					else 				ns = pos3;
			pos4: if(next)			ns = pos0;
					else if(hit)	ns = gg;
					else 				ns = pos4;
			gg:						ns = gg;
		endcase
	end
	
	always_comb begin
		case(ps)
			pos0:	pixels = 16'b1100011000110001;
			pos1:	pixels = 16'b0110001100011000;
			pos2:	pixels = 16'b0011000110001100;
			pos3:	pixels = 16'b0001100011000110;
			pos4: pixels = 16'b1000110001100011;
			gg: 	pixels = 16'b1001100110001001;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= pos0;
		else
			ps <= ns;
	end
endmodule