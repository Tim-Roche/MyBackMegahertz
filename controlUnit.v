module controlUnit(clock, reset, IR, status, controlWord, k);
parameter CUL = 35;
input clock;
input status;
input reset;
input [31:0] IR;
output [CUL:0] controlWord;
output [31:0] k;
reg  [3:0] state;
wire [3:0] NS;

wire iFetch = ~state[2] & ~state[1] & ~state[0];
wire DP_imm_sel = (IR[28] & ~IR[27] & ~IR[26])&~iFetch;
wire branch_sel = (IR[28] & ~IR[27] &  IR[26])&~iFetch;
wire loadSr_sel = (IR[27] & ~IR[25])& ~iFetch;
wire DP_reg_sel = (IR[27] &  IR[25] & ~IR[26])&~iFetch;

wire [3:0] NS_reg;
wire [3:0] NS_iFh;
wire [CUL:0] reg_CW;
wire [CUL:0] iFetch_CW;

CU_iFetch iUnit(opcode, state, status, SA, SB, DA, NS_reg, k_mux, iFetch_CW);
CU_reg regUnit (opcode, state, status, SA, SB, DA, NS_iFh, k_mux, reg_CW);

assign NS = (iFetch) ?    NS_iFh :
				(DP_reg_sel) ? NS_reg:
				 3'b000; 
				 
assign controlWord = (iFetch) ?  iFetch_CW :
							(DP_reg_sel) ? reg_CW :
							 37'd0;

Mux8to1Nbit constantGenerator (k, k_sel, 32'b0, IR[21:10], IR[19:11], IR[31:6], IR[26:8], IR[26:11], 32'b0, 32'b0);
defparam constantGenerator.N = 32;

always @(posedge clock) begin
	if(reset) 
		state <= 3'b000;
	else
		state <= NS;
end
endmodule