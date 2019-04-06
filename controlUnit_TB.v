module controlUnit_TB();
parameter CUL = 36;
reg clock = 1'b0;
reg reset = 1'b0;

reg [3:0] status = 4'b0000;
reg [31:0] IR;
wire [CUL:0] controlWord;
wire [31:0] k;
wire [3:0] state = cu.state;
wire [3:0] NS = cu.NS;
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
*/

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

controlUnit cu (clock, reset, IR, status, controlWord, k);

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
	IR = {11'b11010110000,21'b10}; 
	#200 $stop;
end

endmodule