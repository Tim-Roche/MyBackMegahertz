// auto generated from http://users.rowan.edu/~haskellt8/assembler/
module rom_case(out, address);
	output reg [31:0] out;
	input  [15:0] address; // address- 16 deep memory  
	always @(address) begin
		case (address)
			// Overclock (Nice!) Test
			// use X8 as the base address of RAM (default is 0x00000000)
			// For example if RAM is at 0x80000000 then change the following two instructions to:
			// MOVZ X8, 8 (put 8 in X8)
			// LSL X8, X8, 28 (shift it 28 times to get 0x80000000)
			16'h0000:  out = 32'b11010010100_0000000000000000_01000; // MOVZ X8, 0
			16'h0004:  out = 32'b1101001101100000_000000_0100001000; // LSL X8, X8, 0
			// use X11 as the base address of ROM (default is 0x00008000)
			16'h0008:  out = 32'b11010010100_0000000000001000_01011; // MOVZ X11, 8
			16'h000C:  out = 32'b1101001101100000_001100_0101101011; // LSL X11, X11, 12
			// X7 will hold the delay amount
			16'h0010:  out = 32'b11010010100000000000000000100111; // MOVZ X7, 1
			// change the shift amount to change the delay
			// if using a testbench to debug then change the shift amount to 1
			16'h0014:  out = 32'b1101001101100000_011000_0011100111; // LSL X7, X7, 24
			16'h0018:  out = 32'b11111000000000110000000100000111; // STUR X7, [X8, 48]
			16'h001C:  out = 32'b11010001000001100101011111100000; // SUBI X0, XZR, 405
			16'h0020:  out = 32'b11010001000100000000001111100101; // SUBI X5, XZR, 1024
			16'h0024:  out = 32'b10110010000001000110011111100010; // ORRI X2, XZR, 281
			16'h0028:  out = 32'b10001011000001010000000001000010; // ADD X2, X2, X5
			16'h002c:  out = 32'b10001011000001010000000000000000; // ADD X0, X0, X5
			16'h0030:  out = 32'b10001011000001010000000010100101; // ADD X5, X5, X5
			16'h0034:  out = 32'b10001011000000100000000010100010; // ADD X2, X5, X2
			16'h0038:  out = 32'b11010011011000000000010010100101; // LSL X5, X5, 1
			16'h003C:  out = 32'b10001011000001010000000000000000; // ADD X0, X0, X5
			16'h0040:  out = 32'b11010011011000000000010010100101; // LSL X5, X5, 1
			16'h0044:  out = 32'b10001011000001010000000001000010; // ADD X2, X2, X5
			16'h0048:  out = 32'b11001011000001010000001111100101; // SUB X5, XZR, X5
			16'h004C:  out = 32'b10001011000000100000000000000000; // ADD X0, X0, X2
			16'h0050:  out = 32'b10001011000000100000000000000000; // ADD X0, X0, X2
			16'h0054:  out = 32'b11111000000000011000000100000000; // STUR X0, [X8, 24]
			16'h0058:  out = 32'b11111000000000100000000100000010; // STUR X2, [X8, 32]
			16'h005C:  out = 32'b11111000000000101000000100000101; // STUR X5, [X8, 40]
			16'h0060:  out = 32'b10010001000000000000001111100000; // ADDI X0, XZR, 0
			16'h0064:  out = 32'b10010010000000000000001111100001; // ANDI X1, XZR, 0
			16'h0068:  out = 32'b11010010000000000000001111100010; // EORI X2, XZR, 0
			16'h006C:  out = 32'b10110010000000000000001111100011; // ORRI X3, XZR, 0
			16'h0070:  out = 32'b10101010000111110000001111100100; // ORR X4, X31, X31
			16'h0074:  out = 32'b10001010000111110000001111100101; // AND X5, X31, X31
			16'h0078:  out = 32'b10001010000111110000001111100110; // AND X6, X31, X31
			16'h007C:  out = 32'b11111000010000110000000100000111; // LDUR X7, [X8, 48]
			16'h0080:  out = 32'b11010001000000000000010011100111; // SUBI X7, X7, 1
			16'h0084:  out = 32'b10110101111111111111111111000111; // CBNZ X7, -2
			16'h0088:  out = 32'b11010010100111111111111111100000; // MOVZ X0, 65535
			16'h008C:  out = 32'b11010001000000000000011111100001; // SUBI X1, XZR, 1
			16'h0090:  out = 32'b11010010100111111111111111100010; // MOVZ X2, 65535
			16'h0094:  out = 32'b11010001000000000000011111100011; // SUBI X3, XZR, 1
			16'h0098:  out = 32'b11010010100111111111111111100100; // MOVZ X4, 65535
			16'h009C:  out = 32'b11010001000000000000011111100101; // SUBI X5, XZR, 1
			16'h00A0:  out = 32'b11010001000000000000011111100110; // SUBI X6, XZR, 1
			16'h00A4:  out = 32'b11111000010000110000000100000111; // LDUR X7, [X8, 48]
			16'h00A8:  out = 32'b11010001000000000000010011100111; // SUBI X7, X7, 1
			16'h00AC:  out = 32'b10110101111111111111111111000111; // CBNZ X7, -2
			16'h00B0:  out = 32'b11111000010000011000000100000100; // LDUR X4, [X8, 24]
			16'h00B4:  out = 32'b11111000010000100000000100000010; // LDUR X2, [X8, 32]
			16'h00B8:  out = 32'b11111000010000101000000100000101; // LDUR X5, [X8, 40]
			16'h00BC:  out = 32'b10010001000000000000000001000011; // ADDI X3, X2, 0
			16'h00C0:  out = 32'b10110010000000010000000001100011; // ORRI X3, X3, 64
			16'h00C4:  out = 32'b11010010100000000000000100000111; // MOVZ X7, 8
			16'h00C8:  out = 32'b11001011000001110000000001100011; // SUB X3, X3, X7
			16'h00CC:  out = 32'b11010010100000000000000000100111; // MOVZ X7, 1
			16'h00D0:  out = 32'b11001010000001110000000001100001; // EOR X1, X3, X7
			16'h00D4:  out = 32'b11001011000001010000000000100001; // SUB X1, X1, X5
			16'h00D8:  out = 32'b10110010000000000000000010000000; // ORRI X0, X4, 0
			16'h00DC:  out = 32'b11010010100000000000000000000101; // MOVZ X5, 0
			16'h00E0:  out = 32'b11010010100000000000000000000110; // MOVZ X6, 0
			16'h00E4:  out = 32'b11111000010000110000000100000111; // LDUR X7, [X8, 48]
			16'h00E8:  out = 32'b11010001000000000000010011100111; // SUBI X7, X7, 1
			16'h00EC:  out = 32'b10110101111111111111111111000111; // CBNZ X7, -2
			16'h00D0:  out = 32'b11010110000000000000000101100000; // BR X11
			default: out=32'b11010110000000000000000101100000; //BR X11
		endcase
	end
endmodule