module scoreboard(clk, reset, point, overflow, score);
	input logic clk, reset, point;
	output logic [6:0] score;
	output logic overflow;
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} ps, ns;
	
	always_comb begin
		case(ps)
			zero: 	if(point)	ns = one;
						else			ns = zero;
			one: 		if(point)	ns = two;
						else			ns = one;
			two: 		if(point)	ns = three;
						else			ns = two;
			three: 	if(point)	ns = four;
						else			ns = three;
			four: 	if(point)	ns = five;
						else			ns = four;
			five: 	if(point)	ns = six;
						else			ns = five;
			six: 		if(point)	ns = seven;
						else			ns = six;
			seven: 	if(point)	ns = eight;
						else			ns = seven;
			eight: 	if(point)	ns = nine;
						else			ns = eight;
			nine: 	if(point)	ns = zero;
						else			ns = nine;
		endcase
	end
	
	always_comb begin
		case(ps)
			zero:		score = 7'b1000000;
			one: 		score = 7'b1111001;
			two: 		score = 7'b0100100;
			three: 	score = 7'b0110000;
			four:		score = 7'b0011001;
			five: 	score = 7'b0010010;
			six: 		score = 7'b0000010;
			seven: 	score = 7'b1111000;
			eight: 	score = 7'b0000000;
			nine: 	score = 7'b0011000;
		endcase
	end
	
	always_comb begin
		case(ps)
			zero:		overflow = 1'b0;
			one: 		overflow = 1'b0;
			two: 		overflow = 1'b0;
			three: 	overflow = 1'b0;
			four:		overflow = 1'b0;
			five: 	overflow = 1'b0;
			six: 		overflow = 1'b0;
			seven: 	overflow = 1'b0;
			eight: 	overflow = 1'b0;
			nine: 	if(ns == zero)	overflow = 1'b1;
						else				overflow = 1'b0;	
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= zero;
		else
			ps <= ns;
	end
endmodule

module scoreboard_testbench();
	logic clk, reset, switch, lastLight;
	logic [6:0] score;
	
	scoreboard dut (clk, reset, switch, lastLight, score);
	
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
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		lastLight 	<= 1;					@(posedge clk);
		switch		<= 1;					@(posedge clk);
		switch		<= 0;					@(posedge clk);
		
		
		
		$stop; // End the simulation.
	end
endmodule