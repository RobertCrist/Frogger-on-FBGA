module normalLight (clk, reset, L, R, NL, NR, lightOn);
	input logic 		clk, reset;
	input logic  		L, R, NL, NR;
	output logic 		lightOn;
	
	enum {off, on} ps, ns;

	always_comb begin
		case (ps)
			off: 	if ((L & NR) | (R & NL))	ns = on;
					else 								ns = off;
			on: 	if ((L & ~R) | (~L & R)) 	ns = off;
					else 								ns = on;				
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
			ps <= off;
		else
			ps <= ns;
	end
endmodule

module normalLight_testbench();
	logic clk, reset, L, R, NL, NR;
	logic lightOn;
	
	normalLight dut (clk, reset, L, R, NL, NR, lightOn);
	
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
						L 	<= 1; R <= 0;	@(posedge clk);
						L 	<= 0;  			@(posedge clk);
						NR <= 1;				@(posedge clk);
												@(posedge clk);
												@(posedge clk);
						L 	<= 1; 			@(posedge clk);
						L 	<= 0; 			@(posedge clk);
						NR <= 0;				@(posedge clk);
												@(posedge clk);
						L 	<= 1; 			@(posedge clk);
						L 	<= 0;				@(posedge clk);
						NL <= 1;				@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
						R 	<= 1; 			@(posedge clk);
						R 	<= 0; 			@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		$stop; // End the simulation.
	end
endmodule