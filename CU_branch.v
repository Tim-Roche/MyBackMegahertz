module CU_branch(IR, state, status, NS, k_mux, controlWord);
parameter CUL = 36;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [3:0] NS;
output [CUL:0] controlWord;

wire [2:0] trimOp1 = IR[31:29];
wire [1:0] trimOp0 = IR[25:24];

wire V, C, N, Z;

assign {V, C, N, Z} = status;

wire UNUSED7, BR, CB, BL, UNUSED3, bcond, UNUSED1, B;
Decoder3to8 opToSignal ({UNUSED7, BR, CB, BL, UNUSED3, bcond, UNUSED1, B},trimOp1, 1'b1);
wire CBZ  = CB &~trimOp0[1]&~trimOp0[0];
wire CBNZ = CB &~trimOp0[1]& trimOp0[0];

wire EX0 = (state == 4'b0001) ? 1'b1 : 1'b0;
wire EX1 = (state == 4'b0010) ? 1'b1 : 1'b0;

assign NS = (BR)     ? 4'b0000 : 
            (EX0&~BR)? 4'b0010 :
				(EX1)    ? 4'b0000 : 4'b0000;

wire [4:0] FS           = 5'b00100; //OR
wire [4:0] SA           = 5'd31;
wire [4:0] SB           = IR[4:0];
wire [4:0] DA           = 5'd28; //RL 

wire w_reg              = EX0&BL;
wire C0                 = 1'b0;
wire [1:0] mem_cs       = 2'b00;
wire B_Sel              = 1'b0;
wire mem_write_en       = 1'b0;
wire IR_load            = 1'b0;
wire status_load        = CB&EX0;
wire [1:0] size         = 2'b00;
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = 2'b10;
wire PC_sel             = 1'b0;
wire [2:0] k_mux        = 3'b000;

wire [1:0] PC_FS;
wire PC_HOLD = EX0&~BR;
wire PC_PLUS4 = (EX1&CBZ&~Z) | (EX1&CBNZ&Z);
wire PC_JUMP = (EX1&CBZ&Z) | (EX1&CBNZ&~Z) | (BL&EX1);
wire PC_IN = BR;

assign PC_FS = PC_HOLD  ? 2'b00 : 
				PC_PLUS4 ? 2'b01 :
				PC_IN    ? 2'b10 : 2'b11;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule