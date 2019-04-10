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
			//32'h00000000: out = {10'b1001000100,12'd2047 ,5'd31 ,5'd0}; //ADDI X0 X31 #hAAA
			32'h00000000: out = {10'b1101000100, 12'd1, 5'd31, 5'd0}; // SUBI X0 X31 #1
			32'h00000004: out = {11'b01111000000, 9'd0, 2'd0, 5'd31, 5'd0}; //STURH X0 X31 #0 
			32'h00000008: out = {10'b1001000100,12'd12, 5'd31 ,5'd31}; //ADDI X31 X31 #12
			32'h0000000C: out = {11'b01111000010, 9'd0, 2'd0, 5'd31, 5'd1}; //LOADH X1 [X31 #0]
			//32'h0000000C: out = {11'b00111000010, 9'd0, 2'd0, 5'd31, 5'd1}; //LOADB X1 X31 #0 
			//32'h00000004: out = {11'b11111000000, 9'd8, 2'd0, 5'd7, 5'd0}; //STUR X0 [X7, #6]
			//32'h00000008: out = {10'b1001000100,12'd456 ,5'd31 ,5'd1}; //ADDI X0 X31 #hAAA
			//32'h00000004: out = {11'b01111000000,9'd2, 2'd0, 5'd7, 5'd0}; //STURH X0 [X7, #0]
			//32'h0000000C: out = {11'b11111000010,9'd8, 2'b0, 5'd7, 5'd1};//LDUR X1 [X7, #0]
			//32'h00000000: out = {10'b1001000100,12'd10 ,5'd31 ,5'd0}; //ADDI X0 X31 #10
			//32'h00000004: out = {10'b1101000100,12'd		05 ,5'd00 ,5'd1}; //SUBI X1 X0 #5
			//32'h00000008: out = {11'b10101010000, 5'd0, 6'd0, 5'd1, 5'd3}; //ORR X3 X1 X0 
			//32'h0000000C: out = {11'b11111000000, 9'd6, 2'd0, 5'd0, 5'd3}; //STUR X3 [X0, #6]
			//32'h00000010: out = {11'b11111000010,9'd11, 2'b0, 5'd1, 5'd4};//LDUR X4 [X1, #11]
			//32'h00000014: out = {8'b10110101, 19'd1, 5'd4}; //CBNZ X4 #1
			//32'h00000018: out = {10'b1001000100,12'd245 ,5'd31 ,5'd0}; //ADDI X0 X31 #245
			//32'h0000001C: out = {6'b000101,{{22{1'b1}},4'b1000}}; //B -8
			default: out = 64'h0000;
		endcase
	end
endmodule
			
			