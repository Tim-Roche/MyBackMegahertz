module controlUnit(clock, reset, IR, status, controlWord, k);
parameter CUL = 36;
input clock;
input [3:0] status;
input reset;
input [31:0] IR;
output [CUL:0] controlWord;
output wire [31:0] k;
reg  [3:0] state = 4'b0000;
wire [3:0] NS;
wire [2:0] k_sel;
wire [5:0] shamt;

wire [2:0] k_sel_iFh;
wire [2:0] k_sel_reg;
wire [2:0] k_sel_b;
wire [2:0] k_sel_imm;
wire [2:0] k_sel_ls;

wire iFetch = ~state[3]&~state[2] & ~state[1] & ~state[0];
wire DP_imm_sel = (IR[28] & ~IR[27] & ~IR[26])&~iFetch;
wire branch_sel = (IR[28] & ~IR[27] &  IR[26])&~iFetch;
wire loadSr_sel = (IR[27] & ~IR[25])& ~iFetch;
wire DP_reg_sel = (IR[27] &  IR[25] & ~IR[26])&~iFetch;

wire [3:0] NS_reg;
wire [3:0] NS_iFh;
wire [3:0] NS_b;
wire [3:0] NS_imm;
wire [3:0] NS_ls;
wire [CUL:0] reg_CW;
wire [CUL:0] iFetch_CW;
wire [CUL:0] bch_CW;
wire [CUL:0] imm_CW;
wire [CUL:0] ls_CW;

CU_iFetch iUnit   (IR, state, status,  NS_iFh, k_sel_iFh, iFetch_CW);
CU_reg regUnit    (IR, state, status,  NS_reg, k_sel_reg, reg_CW);
CU_branch bchUnit (IR, state, status, NS_b, k_sel_b, bch_CW);
CU_imm    immUnit (IR, state, status, NS_imm, k_sel_imm, imm_CW, shamt);
CU_LS      lsUnit (IR, state, status, NS_ls, k_sel_ls, ls_CW); 

assign {NS,controlWord,k_sel} = (iFetch) ?  {NS_iFh, iFetch_CW, k_sel_iFh} :
								  (DP_reg_sel)   ?  {NS_reg, reg_CW, k_sel_reg}    :
								  (branch_sel)   ?  {NS_b, bch_CW, k_sel_b}        :
								  (DP_imm_sel)   ?  {NS_imm, imm_CW, k_sel_imm}    :
								  (loadSr_sel)  ?  {NS_ls, ls_CW, k_sel_ls}       :
								   50'd0; 
				 
				                             //000            ,  001             ,            010 ,              011,            100,             101,     110,               111
Mux8to1Nbit constantGenerator (k, k_sel, {20'b0,IR[21:10]}, {23'b0,IR[20:12]}, {6'b0,IR[25:0]}, {13'b0,IR[23:5]}, {16'b0,IR[20:5]}, {16'b0, 16'hFFFF}, {26'b0, shamt}, 32'b0);
defparam constantGenerator.N = 32;

always @(posedge clock) begin
	if(reset) 
		state <= 4'b0000;
	else
		state <= NS;
end
endmodule