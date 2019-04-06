module controlUnit_TB();
parameter CUL = 36;
reg clock = 1'b0;
reg reset = 1'b0;

reg status = 4'b0000;
reg [31:0] IR;
wire [CUL:0] controlWord;
wire [31:0] k;
wire [3:0] state = cu.state;
wire [3:0] NS = cu.NS;
wire [CUL:0] regCW = cu.reg_CW;
wire [31:0] iK = cu.k_sel_iFh;
wire [2:0] ksel = cu.k_sel;
wire [4:0] rFS = cu.regUnit.FS;
wire ADD = cu.regUnit.ADD;
wire SUB = cu.regUnit.SUB;
wire ADDS = cu.regUnit.ADDS;
wire SUBS = cu.regUnit.SUBS;
wire AND = cu.regUnit.AND;
wire ORR = cu.regUnit.ORR;
wire EOR = cu.regUnit.EOR;
wire ANDS = cu.regUnit.ANDS;
wire [2:0] trimOp = cu.regUnit.trimOp;


controlUnit cu (clock, reset, IR, status, controlWord, k);

wire [CUL:0] iCW = cu.iFetch_CW;
wire [3:0] iNS  = cu.NS_iFh;

wire iFetch = cu.iFetch;
wire DP_imm_sel = cu.DP_imm_sel;k
wire branch_sel = cu.branch_sel;
wire loadSr_sel = cu.loadSr_sel;
wire DP_reg_sel = cu.DP_reg_sel;

always begin
	#20 clock <= ~clock;
end

initial begin 
	IR = {11'b10101010000,5'd1,6'd0,5'd0,5'd2}; //ADD X2 X0 X1
	#100 $stop;
end

endmodule