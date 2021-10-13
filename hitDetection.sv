module hitDetection(clk, reset, GrnPixels, RedPixels, out);
	input logic clk, reset;
	input logic [15:0][15:0] GrnPixels, RedPixels;
	
	output logic out;
	
	
	enum {safe, hit} ps, ns;
	
	int i, j;
	integer scan;
	
	always_comb begin
		scan = 0;
		for(i = 0; i < 16; i = i + 1)begin
			for(j = 0; j < 16; j = j + 1)begin	
				if(GrnPixels[i][j] == 1 & GrnPixels[i][j] == RedPixels[i][j])begin
					scan = 1;
				end
			end
		end
	end
	
	always_comb begin
		case(ps)
			safe:	if(scan == 1)	ns = hit;
					else				ns = safe;
				/*for(i = 0; i < 16; i = i + 1)begin
					for(j = 0; j < 16; j = j + 1)begin	
						if(GrnPixels[i][j] == 1 & GrnPixels[i][j] == RedPixels[i][j]) ns = hit;
						else ns = safe;	
					end
				end
				if(GrnPixels[1][1] == 1 & GrnPixels[1][1] == RedPixels[1][1]) ns = hit;
				else ns = safe;*/	
			hit:						ns = safe;
		endcase
	end
	
	always_comb begin
		case(ps)
			safe:	out = 1'b0;
			hit:	out = 1'b1;
		endcase
	end
	
	/*always_comb begin
		case(ps)
			safe:	scan = scan;
			hit:	scan = 0;
		endcase
	end*/
	always_ff @(posedge clk) begin
		if (reset)
			ps <= safe;
		else
			ps <= ns;
	end
endmodule