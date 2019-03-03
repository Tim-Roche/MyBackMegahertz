module dataPath_V2_TB();
reg [63:0] k;
reg [4:0] FS;
reg B_Sel;
reg EN_B = 1'b0;
reg EN_ALU = 1'b0;
reg w_reg = 1'b0;
reg reset_reg = 1'b0;
reg C0 = 1'b0;
reg [4:0] SA = 5'b00000;
reg [4:0] SB = 5'b00000;
reg [4:0] DA = 5'b00000;
wire [63:0] data_bus;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
reg clock = 1'b0;
reg ram_cs = 1'b1;
reg ram_write_en = 1'b0;
reg ram_read_en = 1'b0;
reg EN_ADDR_ALU = 1'b0;
reg [1:0] ramOutsize = 2'b11;
 
					//r0, r1, r2, r3, r4, r5, r6, r7, data_bus, k, FS, B_Sel, EN_B, EN_ALU, EN_ADDR_ALU, ram_cs, ram_write_en, ram_read_en, w_reg, reset_reg, clock, SA, SB, DA, C0
dataPath_V2 dp (r0, r1, r2, r3, r4, r5, r6, r7, data_bus, k, FS, B_Sel, EN_B, EN_ALU, EN_ADDR_ALU, ram_cs, ram_write_en, ram_read_en, w_reg, reset_reg, ramOutsize, clock, SA, SB, DA, C0);

wire [31:0] add = dp.addressLine;
wire [63:0] regOutB = dp.regOut_B;
wire [63:0] regOutA = dp.regOut_A;
wire [63:0] muxOut = dp.muxOut;
wire [63:0] aluOut = dp.alu_out;

always begin
	#5 clock <= ~clock;
end

initial begin
	//LOAD X0 with 10;
	#5;
	k = 64'd10;
	EN_ALU = 1'b1;
	FS = 5'b01100; //OR
	DA = 5'b00000;
	SA = 5'd31;	
	w_reg = 1'b1;
	B_Sel = 1'b1;
	#5;
	EN_ALU = 1'b0;
	#5;	
	//X1 <= X0 + 5
	k = 64'd5;
	FS = 5'b01000; //ADD
	DA = 5'b00001;
	SA = 5'd0;
	EN_ALU = 1'b1;
	//X3 <= X0;
	#5;
	EN_ALU = 1'b0;
	#5; 
	DA = 5'b00011;
	SB = 5'd0;
	EN_B = 1'b1;
	#5;
	EN_B = 1'b0;
	w_reg = 1'b0;
	//Testing RAM
	#20;
	SA = 5'd31;
	SB = 5'd1;
	FS = 5'b00000; //AND
	EN_ADDR_ALU = 1'b1;
	EN_B = 1'b1;
	ram_write_en = 1'b1;
	#20;
	EN_B = 1'b0;
	ram_write_en = 1'b0;
	#10;
	DA = 5'd4;
	ram_read_en = 1'b1;
	w_reg = 1'b1;
	#10;
	#100 $stop;
end

endmodule
	