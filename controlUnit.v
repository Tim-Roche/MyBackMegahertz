module controlUnit(clock, reset, IR, status, controlWord);
input clock;
input status;
input reset;
input [31:0] IR;
output [36:0] controlWord;
reg  [3:0] state;
wire [3:0] NS;

wire DP_imm_sel = IR[28] & ~IR[27] & ~IR[26];
wire branch_sel = IR[28] & ~IR[27] &  IR[26];
wire loadSr_sel = IR[27] & ~IR[25];
wire DP_reg_sel = IR[27] &  IR[25] & ~IR[26];

wire [3:0] NS_reg;
wire [36:0] reg_CW;
CU_reg(opcode, state, status, SA, SB, DA, NS_reg, reg_CW);

assign NS = (DP_reg_sel) ? NS_reg : 3'b000; 
assign controlWord = (DP_reg_sel) ? reg_CW : 37'd0;

Mux8to1Nbit constantGenerator (k, k_sel, 32'b0, IR[21:10], IR[19:11], IR[31:6], IR[26:8], IR[26:11], 32'b0, 32'b0);
defparam constantGenerator.N = 32;

always @(posedge clock) begin
	if(reset) 
		state <= 3'b000;
	else
		state <= NS;
end
endmodule