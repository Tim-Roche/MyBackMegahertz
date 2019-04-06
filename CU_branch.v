module CU_branch(IR, state, status, NS, k_mux, controlWord);
parameter CUL = 36;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [2:0] NS;
output [CUL:0] controlWord;
wire [10:0] opcode = IR[31:21];
wire [2:0] trimOp1 = opcode[31:29];
wire [1:0] trimOp0 = opcode[25:24];

wire UNUSED7, BR, CB, BL, UNUSED3, bcond, UNUSED1, B;
Decoder3to8 opToSignal ({UNUSED7, BR, CB, BL, UNUSED3, bcond, UNUSED1, B},trimOp1, 1'b1);
wire CBZ  = CB &~trimOp0[1]&~trimOp0[0];
wire CBNZ = CB &~trimOp0[1]& trimOp0[0];

wire EX0 = (state == 4'b0001) ? 1'b1 : 1'b0;
wire EX1 = (state == 4'b0010) ? 1'b1 : 1'b0;

assign NS = (BR)     ? 4'b0000 : 
            (EX0&~BR)? 4'b0010 :
				(EX1)    ? 4'b0000;

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
wire status_load        = CB; 
wire [1:0] size         = 2'b00;
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = 2'b00;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = 2'b01;
wire [2:0] k_mux        = 3'b000;

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule

module CU_branch(state, status, opcode, SA_in, SB_in, DA_in, controlWord);
//----DP_reg_sel
input [3:0] state;
input [3:0] status; 
input [10:0] opcode;
input [4:0] SA_in;
input [4:0] SB_in;
input [4:0] DA_in;
output controlWord;
wire [3:0] NS; //All single state instructions
wire [1:0] regAIn;
wire [4:0] SA, SB, DA;
wire w_reg        = 1'b1;
wire C0           = opcode[9];
wire mem_cs       = 2'b01;
wire B_Sel        = 1'b0;
wire mem_write_en = 1'b0;
wire IR_load      = 1'b1;

wire [4:0] FS = 5'b00100;
wire [1:0] size   = 1'b00;
wire add_tri_sel  = 1'b0;
wire data_tri_sel = 1'b0;
wire PC_sel       = 1'b0;
wire [1:0] PC_FS  = 2'b01;
wire [2:0] k_mux  = 2'b00;

wire CBZ;
wire BL;
wire EX0 = (state == 3'b001) ? 1'b1 : 1'b0;
wire EX1 = (state == 3'b010) ? 1'b1 : 1'b0;
wire status_zero;

wire PC_HOLD = EX0&CBZ;
wire PC_PLUS4 = EX1&CBZ&~status_zero;
wire PC_JUMP = EX1&CBZ&status_zero;
wire PC_IN = 1'b0;

wire status_load  = (CBZ&EX0);
assign PC = PC_HOLD  ? 2'b00 : 
				PC_PLUS4 ? 2'b01 :
				PC_IN    ? 2'b10 : 2'b11;
assign NS = ((CBZ|BL)&EX0) ? 3'b001 : 3'b000;
assign SA = (CBZ&EX0) ? 5'd31 : SA_in;

endmodule