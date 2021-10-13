module comparator(A, B, out);
	input logic [9:0] A, B;
	output logic 		out;
	
	assign out = (A > B);
	
endmodule

module comparator_testbench();
	logic [9:0] A, B;
	logic 		out;
	
	comparator dut(A, B, out);
	
	initial begin
				A = 10'b0000000001; B = 10'b0000000000;
		#10 	A = 10'b0000000001; B = 10'b0000001000;
		#10 	A = 10'b0010010001; B = 10'b0100001000;
		#10;
		
	end
endmodule

