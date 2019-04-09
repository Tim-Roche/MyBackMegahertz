module CU_imm (IR, state, status, NS, k_mux, controlWord, shamt);
parameter CUL = 36;
input [3:0] state;
input [3:0] status; 
input [31:0] IR;
output [2:0] k_mux;
output [3:0] NS;
output [5:0] shamt;

output [CUL:0] controlWord;

wire [5:0] shamt = IR[15:10];

wire LOGIC = (IR[28:22] == 7'b1001000) ? 1'b1 : 1'b0;
wire SHIFT = (IR[28:22] == 7'b1001101) ? 1'b1 : 1'b0;
wire MATHI = (IR[28:24] == 5'b10001)   ? 1'b1 : 1'b0;
wire MOV   = (IR[28:23] == 6'b100101)  ? 1'b1 : 1'b0;

wire [1:0] trimOp = IR[30:29];
wire top_zero, top_one, top_two, top_three;
Decoder2to4 opoder ({top_three, top_two, top_one, top_zero},trimOp,1'b1);

wire ANDI  = LOGIC & top_zero;
wire ORRI  = LOGIC & top_one;
wire EORI  = LOGIC & top_two;
wire ANDIS = LOGIC & top_three;
wire ADDI  = MATHI & top_zero;
wire ADDIS = MATHI & top_one;
wire SUBI  = MATHI & top_two;
wire SUBIS = MATHI & top_three;
wire MOVZ  = MOV   & top_two;
wire MOVK  = MOV   & top_three;

wire LSR   = SHIFT &~IR[21];
wire LSL   = SHIFT & IR[21];

wire EX0 = (state == 4'b0001) ? 1'b1 : 1'b0;
wire EX1 = (state == 4'b0010) ? 1'b1 : 1'b0;

wire [3:0] NS = (MOVK&EX0) ? 4'b0010 : 4'b0000;

wire [4:0] FS;

assign FS = (ADDI|ADDIS) ? 5'b01000 : //ADD
				(SUBI|SUBIS) ? 5'b01001 : //SUB
            (ANDI|ANDIS) ? 5'b00000 : //AND
				((MOVK&EX0)) ? 5'b00001 : //AND (NOT B)
  (MOVZ|(MOVK&EX1)|ORRI) ? 5'b00100 : //ORR
				(EORI)		 ? 5'b01100 : //XOR
				(LSR)        ? 5'b10100 : 5'b10000; //LSR : LSL

wire mode_r = LSR|LSL;
wire mode_i = ~mode_r&~MOV;
				
wire [4:0] SA           = IR[9:5];
wire [4:0] SB           = IR[20:16];
wire [4:0] DA           = IR[4:0];
wire w_reg              = 1'b1;
wire C0                 = SUBIS|SUBI;
wire [1:0] mem_cs       = 2'b00;
wire B_Sel              = 1'b1;
wire mem_write_en       = 1'b0;
wire IR_load            = 1'b0;
wire status_load        = (ADDIS|SUBIS|ANDIS);
wire [1:0] size         = 2'b00;
wire add_tri_sel        = 1'b0;
wire [1:0] data_tri_sel = 2'b00;
wire PC_sel             = 1'b0;
wire [1:0] PC_FS        = (MOVK&EX0) ? 2'b00 : 2'b01;

wire [2:0] k_mux = (mode_i) ? 3'b000 :
						 (mode_r) ? 3'b110 :
					  (MOV&~(MOVK&EX0)) ? 3'b100 : 3'b101; //different for bit masking
						 

wire [CUL:0] controlWord = {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS};

endmodule