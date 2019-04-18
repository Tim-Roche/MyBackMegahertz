module bitwiseTristateTB();

reg [3:0] in = 4'b1001;
reg [3:0] enables = 4'b1010;
wire [3:0] out;

bitwiseTristate dut (in, out, enables);

initial begin
	#5;
	enables = 4'b1100;
	#5;
	enables = 4'b0101;
	#10 $stop;
end

endmodule