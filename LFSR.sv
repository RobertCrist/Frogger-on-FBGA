module LFSR(clk, reset, out);
	input logic 			clk, reset;
	output logic [9:0] 	out;
	
	
	always_ff @(posedge clk) begin		
		if(reset)
			out[9:0] = 1'b00000000000;
		else begin
			out[0] 	<= out[1];
			out[1] 	<= out[2];
			out[2] 	<= out[3];
			out[3] 	<= out[4];
			out[4] 	<= out[5];
			out[5] 	<= out[6];
			out[6] 	<= out[7];
			out[7] 	<= out[8];
			out[8] 	<= out[9];
			out[9] 	<= (out[3] ~^ out[0]);
		end
	end
	
endmodule

module LFSR_testbench();
	logic 			clk, reset;
	logic [10:0]	seed;
	logic [9:0] 	out;
	
	LFSR dut (clk, reset, out);
	
	// Set up a simulated clk.
	parameter clk_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD/2) clk <= ~clk; // Forever toggle the clk
	end
	
	// Set up the inputs to the design. Each line is a clk cycle.
	initial begin
													@(posedge clk);
													@(posedge clk);
													@(posedge clk);
		reset <= 1;								@(posedge clk);
		reset <= 0;								@(posedge clk);
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