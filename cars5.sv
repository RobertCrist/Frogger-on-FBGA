module cars5(clk, reset, hit, pixels);
	input logic clk, reset, hit;
	output logic [15:0] pixels;
	
	logic next;
	
	enum {pos0, pos1, pos2, pos3, gg} ps, ns;
	
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
			pos3:	if(next)			ns = pos0;
					else if(hit)	ns = gg;
					else 				ns = pos3;
			gg:						ns = gg;
		endcase
	end
	
	always_comb begin
		case(ps)
			pos0:	pixels = 16'b1100110011001100;
			pos1:	pixels = 16'b0110011001100110;
			pos2:	pixels = 16'b0011001100110011;
			pos3:	pixels = 16'b1001100110011001;
			gg: 	pixels = 16'b1001100110010100;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= pos0;
		else
			ps <= ns;
	end
endmodule