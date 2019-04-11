module computer_tb();
reg clock = 1'b0;
reg reset = 1'b0;

parameter CUL = 35;

computer labComp (clock,reset);

wire [2:0] trimOp1 = labComp.cu.bchUnit.trimOp1;
wire [63:0] reg0_FULL = labComp.dp.regFile.R00;
wire [1:0] maskSize = labComp.cu.maskSize;
wire [63:0] k = labComp.cu.k;
wire [63:0] maskedOutput = labComp.cu.maskedOutput;
wire [63:0] IW_k = labComp.cu.IW_k;


wire [63:0] ALU_A = labComp.dp.regOut_A;
wire [63:0] ALU_B = labComp.dp.muxOut;
wire [63:0] ALU_output = labComp.dp.alu_out;
wire [63:0] ALU_ADD_OUT = labComp.dp.alu.add_output;
wire [63:0] A_Signal = labComp.dp.alu.A_Signal;
wire [63:0] B_Signal = labComp.dp.alu.B_Signal;
wire C0_ALU = labComp.dp.alu.C0;
wire [4:0] FS_ALU = labComp.dp.alu.FS;

wire [31:0] IR = labComp.IR;

wire [31:0] PC = labComp.dp.pc1.PC;
wire [CUL:0] controlWord = labComp.controlWord;

wire [3:0] state = labComp.cu.state;
wire [3:0] NS = labComp.cu.NS;
wire iFetch = labComp.cu.iFetch;
wire DP_imm_sel = labComp.cu.DP_imm_sel;
wire branch_sel = labComp.cu.branch_sel;
wire loadSr_sel = labComp.cu.loadSr_sel;
wire DP_reg_sel = labComp.cu.DP_reg_sel;

wire UNUSED_select = labComp.UNUSED_select;
wire RAM_select = labComp.RAM_select;
wire ROM_select = labComp.ROM_select;
wire PERIF_select = labComp.PERIF_select;

wire [63:0] data = labComp.mem_data;
wire [31:0] address = labComp.mem_address;
wire [4:0] SA;
wire [4:0] SB;
wire [4:0] DA;
wire w_reg;
wire C0;
wire [1:0] mem_cs;
wire B_Sel;
wire mem_write_en;
wire IR_load;
wire status_load;
wire [1:0] size;
wire add_tri_sel;
wire [1:0] data_tri_sel;
wire PC_sel;
wire [1:0] PC_FS;
wire [4:0] FS;

assign {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS} = controlWord;


wire [15:0] r0 = labComp.r0;
wire [15:0] r1 = labComp.r1;
wire [15:0] r2 = labComp.r2;
wire [15:0] r3 = labComp.r3;
wire [15:0] r4 = labComp.r4;
wire [15:0] r5 = labComp.r5;
wire [15:0] r6 = labComp.r6;
wire [15:0] r7 = labComp.r7;
wire mem_read = labComp.mem_read;
wire SUB = labComp.cu.regUnit.SUB;
wire ADDS = labComp.cu.regUnit.ADDS;
wire SUBS = labComp.cu.regUnit.SUBS;
wire AND = labComp.cu.regUnit.AND;
wire ORR = labComp.cu.regUnit.ORR;
wire EOR = labComp.cu.regUnit.EOR;
wire ANDS = labComp.cu.regUnit.ANDS;
wire ANDI  = labComp.cu.immUnit.ANDI;
wire ORRI  = labComp.cu.immUnit.ORRI;
wire EORI  = labComp.cu.immUnit.EORI;
wire ANDIS = labComp.cu.immUnit.ANDIS;
wire ADDI  = labComp.cu.immUnit.ADDI;
wire SUBI  = labComp.cu.immUnit.SUBI;
wire ADDIS = labComp.cu.immUnit.ADDIS;
wire SUBIS = labComp.cu.immUnit.SUBIS;
wire MOVZ  = labComp.cu.immUnit.MOVZ;
wire MOVK  = labComp.cu.immUnit.MOVK;
wire LSR   = labComp.cu.immUnit.LSR;
wire LSL   = labComp.cu.immUnit.LSL;
wire STUR = labComp.cu.lsUnit.STUR;
wire LDUR = labComp.cu.lsUnit.LDUR;
wire STURB = labComp.cu.lsUnit.STURB;
wire LDURB = labComp.cu.lsUnit.LDURB;
wire STURH = labComp.cu.lsUnit.STURH;
wire LDURH = labComp.cu.lsUnit.LDURH;
wire ADD = labComp.cu.regUnit.ADD;
wire BR = labComp.cu.bchUnit.BR;
wire CB = labComp.cu.bchUnit.CB;
wire BL = labComp.cu.bchUnit.BL;
wire bcond = labComp.cu.bchUnit.bcond;
wire B = labComp.cu.bchUnit.B;
wire CBZ = labComp.cu.bchUnit.CBZ;
always begin 
	#10 clock = ~clock;
end

initial begin
	reset = 1'b1;
	#10;
	reset = 1'b0;
	#3000 $stop;
end



endmodule