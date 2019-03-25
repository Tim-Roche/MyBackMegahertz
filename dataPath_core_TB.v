module dataPath_core_TB();
reg clock = 1'b0;
reg reset = 1'b0;
reg w_reg = 1'b0;
reg C0 = 1'b0;
reg mem_cs = 1'b1;
reg mem_write_en = 1'b0;
reg IR_load = 1'b0;
reg status_load = 1'b0;
reg [31:0] k = 32'b0;
reg [4:0] FS;
reg [1:0] size = 2'b11;
reg [4:0] SA = 5'b00000;
reg [4:0] SB = 5'b00000;
reg [4:0] DA = 5'b00000;
reg add_tri_sel = 1'b0;
reg [1:0] data_tri_sel = 2'b00;
reg [1:0] PC_FS = 2'b00;
reg B_Sel = 1'b0;
reg PC_sel = 1'b0;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 
wire [31:0] IR_out;
wire [3:0] status;

					 //clock, reset, w_reg, C0, mem_cs, mem_write_en, IR_load, status_load,  k,  FS,  size, SA, SB, DA, PC_sel,IR_out,status, r0, r1, r2, r3, r4, r5, r6, r7
dataPath_core dp (clock, reset, add_tri_sel, data_tri_sel,  w_reg, C0, mem_cs, mem_write_en, IR_load, status_load,  k,  FS, PC_FS, size, SA, SB, DA, PC_sel, B_Sel, IR_out,status, r0, r1, r2, r3, r4, r5, r6, r7);

wire [63:0] dataBus = dp.data_bus;
wire [31:0] pc_out = dp.PC_out;
wire [3:0] data_tri = dp.data_tri;
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
	#10;
	data_tri_sel = 2'b00;
	B_Sel = 1'b1;
	k = 32'd10;
	FS = 5'b01100; //OR
	DA = 5'b00000;
	SA = 5'd31;	
	w_reg = 1'b1;
	#10;
	//X1 <= X0 + 5
	B_Sel = 1'b1;
	data_tri_sel = 2'b00;
	k = 32'd5;
	FS = 5'b01000; //ADD
	DA = 5'b00001;
	SA = 5'd0;
	//X3 <= X0;
	#10;
	data_tri_sel = 2'b01;
	DA = 5'b00011;
	SB = 5'd0;
	#10;
	w_reg = 1'b0;
	//Testing RAM
	#20;
	SA = 5'd31;
	SB = 5'd1;
	FS = 5'b00000; //AND
	mem_write_en = 1'b1;
	#20;
	data_tri_sel = 2'b00;
	mem_write_en = 1'b0;
	#10;
	DA = 5'd4;
	data_tri_sel = 2'b11;
	w_reg = 1'b1;
	#10;
	//Loading IR
	#20;
	data_tri_sel = 2'b01;
	SB = 5'd1;
	IR_load = 1'b1;
	#10;
	IR_load = 1'b0;
	B_Sel = 1'b1;
	SA = 5'd0;
	k = 32'd20;
	DA = 5'd5;
	FS = 5'b01001; //SUB
	C0 = 1'b1; //Setting Carry in
	data_tri_sel = 2'b00;
	status_load = 1'b1;
	#20;
	DA = 5'd6;
	PC_sel = 1'b0;
	PC_FS = 2'b10;
	#10;
	data_tri_sel = 2'b10;
	#10
	PC_FS = 2'b10;
	#10;
	PC_FS = 2'b00;
	#10;
	PC_FS = 2'b01;
	#10
	PC_FS = 2'b11;
	#30;
	reset = 1'b1;
	#10;
	reset = 1'b0;
	#10 $stop;
end

endmodule
	