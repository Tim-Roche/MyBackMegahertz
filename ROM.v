module ROM(address, data, chip_select, output_enable); 
	input [31:0] address; 
	input chip_select;
	input output_enable;
	output [63:0] data;

	triState romOut (data, out, (output_enable&chip_select));
	reg [63:0] out;
	
	always@(address)
	begin
		case(address)
			32'h0: out = 64'h0000;
			32'h1: out = 64'h1111;
			32'h2: out = 64'h2222;
			32'h3: out = 64'h3333;
			32'h4: out = 64'h4444;
			32'h5: out = 64'h5555;
			32'h6: out = 64'h6666;
			32'h7: out = 64'h7777;
			32'h8: out = 64'h8888;
			32'h9: out = 64'h9999;
			32'hA: out = 64'hAAAA;
			32'hB: out = 64'hBBBB;
			32'hC: out = 64'hCCCC;
			32'hD: out = 64'hFFFF;
			32'hE: out = 64'h1234;
			32'hF: out = 64'hABCD;
			default: out = 64'h0000;
		endcase
	end
endmodule
			
			