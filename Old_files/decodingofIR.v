input [31:0] IR;
wire DP_imm_sel = IR[28] & ~IR[27] & ~IR[26];
wire branch_sel = IR[28] & ~IR[27] &  IR[26];
wire loadSr_sel = IR[27] & ~IR[25];
wire DP_reg_sel = IR[27] & ~IR[26] &  IR[25];

