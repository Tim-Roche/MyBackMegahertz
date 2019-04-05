module ROM_testbench();
	reg [3:0] address;
	wire [15:0] out;
	
	ROM rom1 (.out(out), .address(address));
	
	integer count;
	
	always @(count) begin
		address <= count;
	end
	
	initial begin
		for(count = 0; count < 16; count = count + 1)
			#10;
	end
	
	initial begin
		#500 $stop;
	end
	
endmodule
	
