input [31:0] IR;
wire DP_imm_sel = IR[28] & ~IR[27] & ~IR[26];
wire branch_sel = IR[28] & ~IR[27] &  IR[26];
wire loadSr_sel = IR[27] & ~IR[25];
wire DP_reg_sel = IR[27] & ~IR[26] &  IR[25];

//----DP_reg_sel
input [3:0] state;
input [3:0] status; 
input [10:0] opcode;
input [4:0] SA;
input [4:0] SB;
input [4:0] DA;
output controlWord;
wire [3:0] NS     = 3'b000; //All single state instructions
wire [4:0] FS; //lol good luck with this one!
wire w_reg        = 1'b1;
wire C0           = opcode[9];
wire mem_cs       = 1'b0;
wire B_Sel        = 1'b0;
wire mem_write_en = 1'b0;
wire IR_load      = 1'b1;
wire status_load  = opcode[8]&opcode[3] + opcode[9]&opcode[8]; //B&E + A&B
wire [1:0] size   = 1'b00;
wire add_tri_sel  = 1'b0;
wire data_tri_sel = 1'b0;
wire PC_sel       = 1'b0;
wire [1:0] PC_FS  = 2'b01;
wire [2:0] k_mux  = 2'b00;