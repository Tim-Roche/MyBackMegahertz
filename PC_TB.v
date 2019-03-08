module PC_TB();
	reg [63:0]in = 64'b1010;
	reg [1:0]PS; // Program counter function Select bits
	reg clock = 1'b0;
	reg reset = 1'b0;
	wire [63:0]PC;
	wire [63:0]PC4;
	
		// PS
	// 00 - PC <= PC
	// 01 - PC <= PC+4
	// 10 - PC <= in
	// 11 - PC <= PC+4+in*4
	             //PC, PC4, in, PS, clock, reset
	programCounter dut(PC, PC4, in, PS, clock, reset);
	
	always begin
		#5 clock = ~clock;
	end
	
	initial begin
		#5;
		PS = 2'b10;
		#10;
		PS = 2'b00;
		#10;
		PS = 2'b01;
		#10
		PS = 2'b11;
		#20 $stop;
	end
endmodule
	 