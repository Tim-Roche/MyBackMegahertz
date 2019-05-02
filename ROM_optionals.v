 module ROM_optionals(address, data, chip_select, output_enable); 
	input [31:0] address; 
	input chip_select;
	input output_enable;
	output [63:0] data;
	
	reg [63:0] out;
	triState romOut (data, out, (output_enable&chip_select));
	
	
	always@(address)
	begin
		case(address)
			16'h0000: out = {9'b110100101, 2'b01, 16'hAAAA, 5'd0}; //MOVZ X0, hAAAA (Byte 2)
			16'h0004: out = {9'b111100101, 2'b00, 16'd15, 5'd0}; //MOVK X0, hFF (Byte 0)
			16'h0008: out = {9'b111100101, 2'b10, 16'd52428, 5'd0}; //MOVK X0, d52428 (Byte 3) 
			16'h000C: out = {9'b111100101, 2'b11, 16'd65535, 5'd0}; //MOVK X0, d52428 (Byte 4)
			
			16'h0010:  out = 32'b11010010100000000000100000000010; // MOVZ X2, 64
			
			16'h0014:  out = 32'b10110100000000000000000011000010; // CBZ X2, 6
			16'h0018:  out = 32'b11010011010000000100000000000100; // LSR X4, X0, 16
			16'h001C:  out = {11'b01111000000, 9'd1, 2'b00, 5'd31, 5'd4}; //STURH X4, [XZR, 1]
			16'h0020:  out = {11'b01111000010, 9'd1, 2'b00, 5'd31, 5'd1}; //LUDRH X1, [XZR, 1]
			16'h0024:  out = 32'b11010011010000000000010000000000; // LSR X0, X0, 1
			16'h0028:  out = 32'b11010001000000000000010001000010; // SUBI X2, X2, 1
			16'h002C:  out = 32'b00010111111111111111111111111001; // B -7
			
			16'h0030: out = 32'hD60003E0; //BR XZR
			default: out = 32'b11010110000000000000000101100000; //BR X11
		endcase
	end
endmodule
		
