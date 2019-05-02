module controlUnit_TB();
parameter CUL = 35;
wire [CUL:0] controlWord;
reg clock = 1'b0;
reg reset = 1'b0;
wire [3:0] NS = cu.lsUnit.NS;
wire [4:0] FS;
wire [4:0] SA;
wire [4:0] SB;
wire [4:0] DA;
wire w_reg;
wire C0;
wire [1:0] mem_cs;
wire B_Sel;
wire mem_write_en;
wire IR_load;
wire status_load ;
wire [1:0] size;
wire add_tri_sel;
wire [1:0] data_tri_sel;
wire PC_sel;
wire [1:0] PC_FS;
wire [2:0] k_mux;
// 				       VCNZ

wire [CUL:0] regCW = cu.reg_CW;
wire [31:0] iK = cu.k_sel_iFh;
wire [2:0] ksel = cu.k_sel;
wire [4:0] rFS = cu.regUnit.FS;
/*wire SUB = cu.regUnit.SUB;
wire ADDS = cu.regUnit.ADDS;
wire ADD = cu.regUnit.ADD;
wire SUBS = cu.regUnit.SUBS;
wire AND = cu.regUnit.AND;
wire ORR = cu.regUnit.ORR;
wire EOR = cu.regUnit.EOR;
wire ANDS = cu.regUnit.ANDS;*/
reg [3:0] status = 4'b1010;
reg [31:0] IR;
wire [31:0] k;
wire [3:0] state = cu.state;
//wire [CUL:0] regCW = cu.reg_CW;
//wire [31:0] iK = cu.k_sel_iFh;
//wire [2:0] ksel = cu.k_sel;
//wire [4:0] rFS = cu.regUnit.FS;
/*wire ADD = cu.regUnit.ADD;
wire SUB = cu.regUnit.SUB;
wire ADDS = cu.regUnit.ADDS;
wire SUBS = cu.regUnit.SUBS;
wire AND = cu.regUnit.AND;
wire ORR = cu.regUnit.ORR;
wire EOR = cu.regUnit.EOR;
wire ANDS = cu.regUnit.ANDS;
wire [2:0] trimOp = cu.regUnit.trimOp;


wire UNUSED7 = cu.bchUnit.UNUSED7;
wire BR = cu.bchUnit.BR;
wire CB = cu.bchUnit.CB;
wire BL = cu.bchUnit.BL;
wire UNUSED3 = cu.bchUnit.UNUSED3;
wire bcond = cu.bchUnit.bcond;
wire UNUSED1 = cu.bchUnit.UNUSED1;
wire B = cu.bchUnit.B;
wire CBZ = cu.bchUnit.CBZ;
wire CBNZ = cu.bchUnit.CBNZ;
wire PC_HOLD = cu.bchUnit.PC_HOLD;
wire PC_PLUS4 = cu.bchUnit.PC_PLUS4;
wire PC_JUMP = cu.bchUnit.PC_JUMP;
wire PC_IN = cu.bchUnit.PC_IN;


wire [4:0] FS = cu.immUnit.FS;

wire top_zero = cu.immUnit.top_zero;
wire top_one = cu.immUnit.top_one;
wire top_two = cu.immUnit.top_two;
wire top_three = cu.immUnit.top_three;
wire [1:0] trimOp = cu.immUnit.trimOp;
wire LOGIC = cu.immUnit.LOGIC;
wire SHIFT = cu.immUnit.SHIFT;
wire MATHI = cu.immUnit.MATHI;
wire MOV   = cu.immUnit.MOV;
wire ANDI  = cu.immUnit.ANDI;
wire ORRI  = cu.immUnit.ORRI;
wire EORI  = cu.immUnit.EORI;
wire ANDIS = cu.immUnit.ANDIS;
wire ADDI  = cu.immUnit.ADDI;
wire SUBI  = cu.immUnit.SUBI;
wire ADDIS = cu.immUnit.ADDIS;
wire SUBIS = cu.immUnit.SUBIS;
wire MOVZ  = cu.immUnit.MOVZ;
wire MOVK  = cu.immUnit.MOVK;

wire LSR   = cu.immUnit.LSR;
wire LSL   = cu.immUnit.LSL;

wire EX0 = cu.immUnit.EX0;
wire EX1 = cu.immUnit.EX1;

*/
wire STUR = cu.lsUnit.STUR;
wire LDUR = cu.lsUnit.LDUR;
wire STURB = cu.lsUnit.STURB;
wire LDURB = cu.lsUnit.LDURB;


wire PC_HOLD = cu.bchUnit.PC_HOLD;
wire PC_PLUS4 = cu.bchUnit.PC_PLUS4;
wire PC_JUMP = cu.bchUnit.PC_JUMP;
wire PC_IN = cu.bchUnit.PC_IN;


wire bcond = cu.bchUnit.bcond;
wire bcondOut = cu.bchUnit.bcondOut;
wire [3:0] s_B = cu.bchUnit.SB[3:0];
controlUnit cu (clock, reset, IR, status, controlWord, k);
assign {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS} = controlWord;
wire [CUL:0] iCW = cu.iFetch_CW;
wire [3:0] iNS  = cu.NS_iFh;

wire iFetch = cu.iFetch;
wire DP_imm_sel = cu.DP_imm_sel;
wire branch_sel = cu.branch_sel;
wire loadSr_sel = cu.loadSr_sel;
wire DP_reg_sel = cu.DP_reg_sel;

always begin
	#20 clock <= ~clock;
end

initial begin 
	IR = 32'b11111000000000000001000000100000; // STUR X0, [X1, 1]
	#200 $stop;
end

endmodule