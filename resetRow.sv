module resetRow(clk, reset, L, R, U, D, aboveRow, belowRow, hit, row);
	input logic clk, reset, L, R, U, D, hit;
	input logic [15:0] aboveRow, belowRow;
	output logic [15:0] row;
	
	frogLightsBottomEdge LED0	(.clk, .reset, .L, .R, .U, .D, .NL(row[1]), 	.NR(row[15]), 	.NU(aboveRow[0]),	.ND(belowRow[0]),	.hit, 		.lightOn(row[0]));
	frogLightsBottomEdge LED1	(.clk, .reset, .L, .R, .U, .D, .NL(row[2]), 	.NR(row[0]), 	.NU(aboveRow[1]),	.ND(belowRow[1]), .hit,		.lightOn(row[1]));
	frogLightsBottomEdge LED2	(.clk, .reset, .L, .R, .U, .D, .NL(row[3]), 	.NR(row[1]), 	.NU(aboveRow[2]),	.ND(belowRow[2]), .hit,		.lightOn(row[2]));
	frogLightsBottomEdge LED3	(.clk, .reset, .L, .R, .U, .D, .NL(row[4]), 	.NR(row[2]), 	.NU(aboveRow[3]),	.ND(belowRow[3]), .hit,		.lightOn(row[3]));
	frogLightsBottomEdge LED4	(.clk, .reset, .L, .R, .U, .D, .NL(row[5]), 	.NR(row[3]), 	.NU(aboveRow[4]),	.ND(belowRow[4]), .hit,		.lightOn(row[4]));
	frogLightsBottomEdge LED5	(.clk, .reset, .L, .R, .U, .D, .NL(row[6]), 	.NR(row[4]), 	.NU(aboveRow[5]),	.ND(belowRow[5]), .hit,		.lightOn(row[5]));
	frogLightsBottomEdge LED6	(.clk, .reset, .L, .R, .U, .D, .NL(row[7]), 	.NR(row[5]), 	.NU(aboveRow[6]), .ND(belowRow[6]),	.hit,		.lightOn(row[6]));
	frogLightsStart 		LED7	(.clk, .reset, .L, .R, .U, .D, .NL(row[8]), 	.NR(row[6]), 	.NU(aboveRow[7]), .ND(belowRow[7]),	.hit, .lightOn(row[7]));
	frogLightsBottomEdge LED8	(.clk, .reset, .L, .R, .U, .D, .NL(row[9]), 	.NR(row[7]), 	.NU(aboveRow[8]), .ND(belowRow[8]),	.hit,		.lightOn(row[8]));
	frogLightsBottomEdge LED9	(.clk, .reset, .L, .R, .U, .D, .NL(row[10]), .NR(row[8]), 	.NU(aboveRow[9]), .ND(belowRow[9]),	.hit,		.lightOn(row[9]));
	frogLightsBottomEdge LED10	(.clk, .reset, .L, .R, .U, .D, .NL(row[11]), .NR(row[9]), 	.NU(aboveRow[10]), .ND(belowRow[10]),.hit,		.lightOn(row[10]));
	frogLightsBottomEdge LED11	(.clk, .reset, .L, .R, .U, .D, .NL(row[12]), .NR(row[10]), 	.NU(aboveRow[11]), .ND(belowRow[11]),.hit,		.lightOn(row[11]));
	frogLightsBottomEdge LED12	(.clk, .reset, .L, .R, .U, .D, .NL(row[13]), .NR(row[11]), 	.NU(aboveRow[12]), .ND(belowRow[12]),.hit,		.lightOn(row[12]));
	frogLightsBottomEdge LED13	(.clk, .reset, .L, .R, .U, .D, .NL(row[14]), .NR(row[12]), 	.NU(aboveRow[13]), .ND(belowRow[13]),.hit,		.lightOn(row[13]));
	frogLightsBottomEdge LED14	(.clk, .reset, .L, .R, .U, .D, .NL(row[15]), .NR(row[13]), 	.NU(aboveRow[14]), .ND(belowRow[14]),.hit,		.lightOn(row[14]));
	frogLightsBottomEdge LED15	(.clk, .reset, .L, .R, .U, .D, .NL(row[0]), 	.NR(row[14]), 	.NU(aboveRow[15]), .ND(belowRow[15]),.hit,		.lightOn(row[15]));
endmodule