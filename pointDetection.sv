module pointDetection(clk, reset, finalRow, U, point);
	input logic clk, reset, U;
	input logic [15:0] finalRow;
	
	output logic point;
	
	enum {noPoint, scored} ps, ns;
	
	int i;
	integer scan;
	
	always_comb begin
		scan = 0;
		for(i = 0; i < 16; i = i + 1)begin
			if(U & finalRow[i])begin
				scan = 1;
			end
		end
	end
	
	always_comb begin
		case(ps)
			noPoint: if(scan == 1)	ns = scored;
						else 				ns = noPoint;
			scored: 						ns = noPoint;
		endcase
	end
	
	always_comb begin
		case(ps)
			noPoint:	point = 1'b0;	
			scored: 	point = 1'b1;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= noPoint;
		else
			ps <= ns;
	end
endmodule
