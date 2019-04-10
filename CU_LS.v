module CU_LS (IR, state, status, NS, k_mux, controlWord);
//----DP_reg_sel
parameter CUL = 35;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [3:0] NS;
output [CUL:0] controlWord;

wire [10:0] opcode = IR[31:21];

wire [4:0] FS;

wire STUR =  (opcode == 11'b11111000000) ? 1'b1 : 1'b0;
wire LDUR =  (opcode == 11'b11111000010) ? 1'b1 : 1'b0;
wire STURB = (opcode == 11'b00111000000) ? 1'b1 : 1'b0;
wire LDURB = (opcode == 11'b00111000010) ? 1'b1 : 1'b0;
wire STURH = (opcode == 11'b01111000000) ? 1'b1 : 1'b0;
wire LDURH = (opcode == 11'b01111000010) ? 1'b1 : 1'b0;

assign FS = 5'b01000;
wire [3:0] NS           = 4'b0000; //All single state instructions
wire [4:0] SA           = IR[9:5];
wire [4:0] SB           = IR[4:0];
wire [4:0] DA           = IR[4:0];
wire w_reg              = LDUR|LDURB|LDURH;
wire C0                 = 1'b0;
wire [1:0] mem_cs       = 2'b01;
wire B_Sel              = 1'b1;
wire mem_write_en       = STUR|STURB|STURH;
wire IR_load            = 1'b0;
wire status_load        = 1'b0;
wire [1:0] size         = (STUR|LDUR)  ? 2'b11 :
								  (STURH|LDURH)? 2'b01 : 2'b00;
								  
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = (LDUR|LDURB|LDURH) ? 2'b11 : 2'b01;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = 2'b01;
wire [2:0] k_mux        = 3'b001;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule