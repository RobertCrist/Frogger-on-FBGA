module upCounter #(parameter WIDTH = 10)(clk, reset, out);
	input logic 	clk, reset;
	output logic 	out;
	logic 			[WIDTH:0] num;
	
	
	always_ff@(posedge clk) begin
		if(reset) num <= 0;
		else if(num[WIDTH] == 1)begin
			out <= 1;
			num <= 0;
		end
		else begin
			out <= 0;
			num <= num + 1;
		end
	end
endmodule	

module upCounter_testbench();
	logic clk, reset, out;
	
	upCounter dut (clk, reset, out);
	
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
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		
		$stop; // End the simulation.
	end
endmodule