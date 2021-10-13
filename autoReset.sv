module autoReset(clk, reset, L, R, lightOn0, lightOn9, out);
	input logic clk, reset, L, R, lightOn0, lightOn9;
	output logic out;
	
	enum {neither, player1, player2} ps, ns;
	
	always_comb begin
		case(ps)
			neither:	if(lightOn9 & L)			ns = player1;
						else if(lightOn0 & R) 	ns = player2;
						else 							ns = neither;
			player1:									ns = neither;
			player2:									ns = neither;
		endcase
	end
	
	always_comb begin
		case(ps)
			neither:	out = 0;
			player1: out = 1;
			player2: out = 1;
		endcase
	end
	
	
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= neither;
		else
			ps <= ns;
	end
endmodule

module autoReset_testbench();
	logic clk, reset, L, R, lightOn0, lightOn9;
	logic out;
	
	autoReset dut (clk, reset, L, R, lightOn0, lightOn9, out);
	
	// Set up a simulated clk.
	parameter clk_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD/2) clk <= ~clk; // Forever toggle the clk
	end
	
	// Set up the inputs to the design. Each line is a clk cycle.
	initial begin
												@(posedge clk);
		reset <= 1; 						@(posedge clk); // Always reset FSMs at start
		reset <= 0; 						@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lightOn9 <= 1;						@(posedge clk);
		L 	<= 1; 							@(posedge clk);
		lightOn9 <= 0;       			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L <= 0;					    		@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		            						@(posedge clk); 
		            						@(posedge clk);
												@(posedge clk);
		lightOn0 <= 1;						@(posedge clk);
		R 	<= 1; 							@(posedge clk);
		lightOn0 <= 0;     				@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		R <= 0;					    		@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		$stop; // End the simulation.
	end
endmodule