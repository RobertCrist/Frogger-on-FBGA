// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC(HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays

	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 //assign SYSTEM_CLOCK = CLOCK_50;
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = ~KEY[0];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 KEY0      : Reset
		 =================================================================== */
	 
	logic L, R, up, down, reset, hit, frogReset, point;
	assign L 		= ~KEY[3];
	assign R 		= ~KEY[2];
	assign up 		= ~KEY[1];
	assign down 	= ~KEY[0];
	assign reset 	= SW[9];
	
	assign frogReset = reset | hit;
	
	logic tempL, cleanL, tempUp, cleanDown, singleL, tempR, singleU, tempDown, cleanR, singleR, cleanUp, singleD;
	logic incr1, incr2, incr3, incr4, incr5;
	logic [8:0] lightOn;
	logic [6:0] display;
	
	always_ff @(posedge SYSTEM_CLOCK) begin
		tempL = L;
		tempR = R;
		tempUp = up;
		tempDown = down;
	end
	
	always_ff @(posedge SYSTEM_CLOCK) begin
		cleanL = tempL;
		cleanR = tempR;
		cleanUp = tempUp;
		cleanDown = tempDown;
	end

	
	
	
	singleOutput finalL (.clk(SYSTEM_CLOCK), .reset, .in(cleanL), .out(singleL));
	singleOutput finalR (.clk(SYSTEM_CLOCK), .reset, .in(cleanR), .out(singleR));
	singleOutput finalUp (.clk(SYSTEM_CLOCK), .reset, .in(cleanUp), .out(singleU));
	singleOutput finalDown (.clk(SYSTEM_CLOCK), .reset, .in(cleanDown), .out(singleD));
	
	hitDetection frogHitDetection(.clk(SYSTEM_CLOCK), .reset, .GrnPixels, .RedPixels, .out(hit));
	
	pointDetection frogPointDetection(.clk(SYSTEM_CLOCK), .reset, .finalRow(GrnPixels[0][15:0]), .U(singleU), .point);
	
	scoreboard scoreBoard0(.clk(SYSTEM_CLOCK), .reset, .point, .score(HEX0[6:0]), .overflow(incr1));
	scoreboard scoreBoard1(.clk(SYSTEM_CLOCK), .reset, .point(incr1), .score(HEX1[6:0]), .overflow(incr2));
	scoreboard scoreBoard2(.clk(SYSTEM_CLOCK), .reset, .point(incr2), .score(HEX2[6:0]), .overflow(incr3));
	scoreboard scoreBoard3(.clk(SYSTEM_CLOCK), .reset, .point(incr3), .score(HEX3[6:0]), .overflow(incr4));
	scoreboard scoreBoard4(.clk(SYSTEM_CLOCK), .reset, .point(incr4), .score(HEX4[6:0]), .overflow(incr5));
	scoreboard scoreBoard5(.clk(SYSTEM_CLOCK), .reset, .point(incr5), .score(HEX5[6:0]), .overflow());
	
	cars1 		redRow1(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[1][15:0]));
	
	gameOver2	redRow2(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[2][15:0]));
	cars3			redRow3(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[3][15:0]));
	gameOver4	redRow4(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[4][15:0]));
	cars5			redRow5(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[5][15:0]));
	gameOver6	redRow6(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[6][15:0]));
	
	cars7			redRow7(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[7][15:0]));
	cars8			redRow8(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[8][15:0]));
	
	gameOver9	redRow9(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[9][15:0]));
	cars10		redRow10(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[10][15:0]));
	gameOver11	redRow11(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[11][15:0]));
	cars12		redRow12(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[12][15:0]));
	gameOver13	redRow13(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[13][15:0]));
	
	cars14 		redRow14(.clk(SYSTEM_CLOCK), .reset, .hit, .pixels(RedPixels[14][15:0]));
	
	resetRow grnRow15(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[14][15:0]), .belowRow(GrnPixels[0][15:0]),  .hit, .row(GrnPixels[15][15:0]));
	
	normalRow grnRow14(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[13][15:0]), .belowRow(GrnPixels[15][15:0]), .hit, .row(GrnPixels[14][15:0]));
	normalRow grnRow13(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[12][15:0]), .belowRow(GrnPixels[14][15:0]), .hit, .row(GrnPixels[13][15:0]));
	normalRow grnRow12(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[11][15:0]), .belowRow(GrnPixels[13][15:0]), .hit, .row(GrnPixels[12][15:0]));
	normalRow grnRow11(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[10][15:0]), .belowRow(GrnPixels[12][15:0]), .hit, .row(GrnPixels[11][15:0]));
	normalRow grnRow10(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[9][15:0]), .belowRow(GrnPixels[11][15:0]), .hit, .row(GrnPixels[10][15:0]));
	normalRow grnRow9(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[8][15:0]), .belowRow(GrnPixels[10][15:0]), .hit, .row(GrnPixels[9][15:0]));
	normalRow grnRow8(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[7][15:0]), .belowRow(GrnPixels[9][15:0]), .hit, .row(GrnPixels[8][15:0]));
	normalRow grnRow7(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[6][15:0]), .belowRow(GrnPixels[8][15:0]), .hit, .row(GrnPixels[7][15:0]));
	normalRow grnRow6(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[5][15:0]), .belowRow(GrnPixels[7][15:0]), .hit, .row(GrnPixels[6][15:0]));
	normalRow grnRow5(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[4][15:0]), .belowRow(GrnPixels[6][15:0]), .hit, .row(GrnPixels[5][15:0]));
	normalRow grnRow4(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[3][15:0]), .belowRow(GrnPixels[5][15:0]), .hit, .row(GrnPixels[4][15:0]));
	normalRow grnRow3(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[2][15:0]), .belowRow(GrnPixels[4][15:0]), .hit, .row(GrnPixels[3][15:0]));
	normalRow grnRow2(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[1][15:0]), .belowRow(GrnPixels[3][15:0]), .hit, .row(GrnPixels[2][15:0]));
	normalRow grnRow1(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(GrnPixels[0][15:0]), .belowRow(GrnPixels[2][15:0]), .hit, .row(GrnPixels[1][15:0]));
	normalRow grnRow0(.clk(SYSTEM_CLOCK), .reset(reset), .L(singleL), .R(singleR), .U(singleU), .D(singleD), .aboveRow(16'b0000000000000000), .belowRow(GrnPixels[1][15:0]), .hit, .row(GrnPixels[0][15:0]));
	
endmodule

module DE1_SoC_testbench();
	logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0]  LEDR;
   logic [3:0]  KEY;
   logic [9:0]  SW;
   logic [35:0] GPIO_1;
   logic CLOCK_50;

	DE1_SoC dut (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design.
	initial begin
										@(posedge CLOCK_50);
		SW[9] <= 1; 				@(posedge CLOCK_50); // Always reset FSMs at start
		SW[9] <= 0;					@(posedge CLOCK_50);
										
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[3] <= 0;				@(posedge CLOCK_50);
		KEY[3] <= 1;				@(posedge CLOCK_50);
		//KEY[3] <= 0;				@(posedge CLOCK_50);
		//KEY[3] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[0] <= 0;				@(posedge CLOCK_50);
		KEY[0] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[2] <= 0;				@(posedge CLOCK_50);
		KEY[2] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[2] <= 0;				@(posedge CLOCK_50);
		KEY[2] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[2] <= 0;				@(posedge CLOCK_50);
		KEY[2] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
		KEY[1] <= 0;				@(posedge CLOCK_50);



		
		
		$stop; // End the simulation.
	end
endmodule