module ROM(address, data, chip_select, output_enable); 
	input [31:0] address; 
	input chip_select;
	input output_enable;
	output [63:0] data;
	
	reg [63:0] out;
	triState romOut (data, out, (output_enable&chip_select));
	
	
	always@(address)
	begin
		case(address)
			32'h0: out = {10'b1001000100,12'd10,5'd31,5'd0}; //ADDI X0 X31 #10
			default: out = 64'h0000;
		endcase
	end
endmodule
			
			