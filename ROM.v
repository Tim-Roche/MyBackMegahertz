module ROM(out, address);
	output reg [15:0] out;
	input [3:0] address;
	
	always@(address)
	begin
		case(address)
			8'h0: out = 16'h0000;
			8'h1: out = 16'h1111;
			8'h2: out = 16'h2222;
			8'h3: out = 16'h3333;
			8'h4: out = 16'h4444;
			8'h5: out = 16'h5555;
			8'h6: out = 16'h6666;
			8'h7: out = 16'h7777;
			8'h8: out = 16'h8888;
			8'h9: out = 16'h9999;
			8'hA: out = 16'hAAAA;
			8'hB: out = 16'hBBBB;
			8'hC: out = 16'hCCCC;
			8'hD: out = 16'hFFFF;
			8'hE: out = 16'h1234;
			8'hF: out = 16'hABCD;
			default: out = 16'h0000;
		endcase
	end
endmodule
			
			