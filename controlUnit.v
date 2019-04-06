module controlUnit(clock, reset, IR, status, controlWord, k);
parameter CUL = 36;
input clock;
input status;
input reset;
input [31:0] IR;
output [CUL:0] controlWord;
output wire [31:0] k;
reg  [3:0] state = 4'b0000;
wire [3:0] NS;
wire [2:0] k_sel;

wire [2:0] k_sel_iFh;
wire [2:0] k_sel_CW;

wire iFetch = ~state[3]&~state[2] & ~state[1] & ~state[0];
wire DP_imm_sel = (IR[28] & ~IR[27] & ~IR[26])&~iFetch;
wire branch_sel = (IR[28] & ~IR[27] &  IR[26])&~iFetch;
wire loadSr_sel = (IR[27] & ~IR[25])& ~iFetch;
wire DP_reg_sel = (IR[27] &  IR[25] & ~IR[26])&~iFetch;

wire [3:0] NS_reg;
wire [3:0] NS_iFh;
wire [CUL:0] reg_CW;
wire [CUL:0] iFetch_CW;

CU_iFetch iUnit(IR, state, status, NS_iFh, k_sel_iFh, iFetch_CW);
CU_reg regUnit (IR, state, status, NS_reg, k_sel_CW, reg_CW);

assign {NS,controlWord,k_sel} = (iFetch) ?  {NS_iFh, iFetch_CW, k_sel_iFh} :
								  (DP_reg_sel)   ?  {NS_reg, reg_CW, k_sel_CW}  :
								  50'd0; 
				 
				 
Mux8to1Nbit constantGenerator (k, k_sel, 32'd0, IR[21:10], IR[19:11], IR[31:6], IR[26:8], IR[26:11], 32'b0, 32'b0);
defparam constantGenerator.N = 32;

always @(posedge clock) begin
	if(reset) 
		state <= 4'b0000;
	else
		state <= NS;
end
endmodule