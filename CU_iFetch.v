module CU_iFetch(opcode, state, status, SA, SB, DA, NS, k_mux, controlWord);
//----DP_reg_sel
input [3:0] state;
input [3:0] status; 
input [10:0] opcode;
input [4:0] SA;
input [4:0] SB;
input [4:0] DA;
output [1:0] k_mux;
output [2:0] NS;
output [35:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_w, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

wire [4:0] FS     = 5'b00000;
wire [3:0] NS     = 3'b001; 
wire w_reg        = 1'b0;
wire C0           = 1'b0;
wire mem_cs       = 2'b10;
wire B_Sel        = 1'b0;
wire mem_write_en = 1'b0;
wire mem_w        = 1'b0;
wire IR_load      = 1'b1;
wire status_load  = 1'b0;
wire [1:0] size   = 1'b11;
wire add_tri_sel  = 1'b1;
wire data_tri_sel = 2'b11;
wire PC_sel       = 1'b0;
wire [1:0] PC_FS  = 2'b00;
wire [2:0] k_mux  = 2'b00;
endmodule