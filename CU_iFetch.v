module CU_iFetch(IR, state, status,  NS, k_sel, controlWord);
parameter CUL = 36;
//----DP_reg_sel
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_sel;
output [3:0] NS;
output [CUL:0] controlWord;

wire [4:0] SA           = 5'd0;
wire [4:0] SB           = 5'd0;
wire [4:0] DA           = 5'd0;
wire [4:0] FS           = 5'd0;
wire [3:0] NS           = 4'b0001; 
wire w_reg              = 1'b0;
wire C0                 = 1'b0;
wire [1:0] mem_cs       = 2'b10;
wire B_Sel              = 1'b0;
wire mem_write_en       = 1'b0;
wire IR_load            = 1'b1;
wire status_load        = 1'b0;
wire [1:0] size         = 2'b11;
wire add_tri_sel        = 1'b1;
wire [1:0] data_tri_sel = 2'b11;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = 2'b00;
wire [2:0] k_sel        = 3'b000;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule