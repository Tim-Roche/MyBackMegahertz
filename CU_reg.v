module CU_reg (IR, state, status, NS, k_mux, controlWord);
//----DP_reg_sel
parameter CUL = 36;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [2:0] NS;
output [CUL:0] controlWord;

wire [2:0] trimOp = {IR[10:9], IR[3]};

wire [4:0] FS;

wire ADD;
wire SUB;
wire ADDS;
wire SUBS;
wire AND;
wire ORR;
wire EOR;
wire ANDS;
Decoder3to8 opToSignal ({SUBS, ANDS, SUB, EOR, ADDS, ORR, ADD, AND},trimOp, 1'b1);

assign FS = (ADD|ADDS) ? 5'b01000 : 
				(SUB|SUBS) ? 5'b01001 :
				(AND|ANDS) ? 5'b01000 :
				(ORR)      ? 5'b00100 : 5'b01100;

wire [3:0] NS           = 4'b0000; //All single state instructions
wire [4:0] SA           = IR[26:22];
wire [4:0] SB           = IR[15:11];
wire [4:0] DA           = IR[31:27];
wire w_reg              = 1'b1;
wire C0                 = IR[9];
wire [1:0] mem_cs       = 2'b01;
wire B_Sel              = 1'b0;
wire mem_write_en       = 1'b0;
wire IR_load            = 1'b0;
wire status_load        = (IR[8]&IR[3]) | (IR[9]&IR[8]); //B&E + A&B
wire [1:0] size         = 2'b00;
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = 2'b00;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = 2'b01;
wire [2:0] k_mux        = 3'b000;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule