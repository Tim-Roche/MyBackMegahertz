module datapath(clock, reset, controlWord, k, status, IR_out, data_bus, addressLine, r0, r1, r2, r3, r4, r5, r6, r7);
input clock;
input reset;
input [35:0] controlWord;
input [31:0] k;

inout wire [63:0] data_bus;
output wire [31:0] addressLine;

output wire [31:0] IR_out;
output [3:0] status;
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 

wire w_reg;
wire C0;
wire [1:0] mem_cs;
wire B_Sel;
wire mem_write_en;
wire IR_load;
wire status_load;
wire [31:0] k;
wire [4:0] FS;
wire [1:0] size;
wire [4:0] SA, SB, DA;
wire add_tri_sel;
wire [1:0] data_tri_sel;
wire PC_sel;
wire [1:0] PC_FS;

assign {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS} = controlWord;

wire add_dec_en = 1'b1;
wire data_dec_en = 1'b1;

wire[63:0] regOut_A, regOut_B;
wire[63:0] alu_out;
wire[63:0] muxOut;

wire [31:0] pc_in;
wire [1:0] add_tri;
wire [3:0] data_tri;

wire [3:0] status_ALU;

wire EN_ALU   = data_tri[0];
wire EN_B     = data_tri[1];
wire EN_PC    = data_tri[2];
wire mem_read = data_tri[3];

wire EN_ADDR_ALU = add_tri[0];
wire EN_ADDR_PC  = add_tri[1];

wire [31:0] PC_out;
wire [31:0] PC_in;
wire [31:0] PC4;

	  	             //A,             B,         SA, SB,        D, DA,     W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7
RegisterFile32x64 regFile(regOut_A, regOut_B, SA, SB, data_bus, DA, w_reg, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7);
					  
					     //PC, PC4, in, PS, clock, reset
programCounter pc1 (PC_out, PC4, PC_in, PC_FS, clock, reset);
										  
										    //Q, D, L, R, clock
RegisterNbit instructionRegister (IR_out, data_bus[31:0], IR_load, reset, clock);
defparam instructionRegister.N = 32;

		            //F, S, I0, I1
mux2to1_Nbit mux(muxOut, B_Sel, regOut_B, {32'b0,k});
mux2to1_Nbit mux1(PC_in, PC_sel, regOut_A[31:0], k);
defparam mux1.N = 32;

Decoder1to2 addDec  (add_tri ,add_tri_sel,add_dec_en);
Decoder2to4 dataDec (data_tri,data_tri_sel,data_dec_en);

		         //A, B, FS, C0, F, status
ALU_LEGv8 alu (regOut_A, muxOut, FS, C0, alu_out, status_ALU);

							  //Q, D, L, R, clock
RegisterNbit statusReg (status, status_ALU, status_load, reset, clock);
defparam statusReg.N = 4;

triState ts1 (data_bus, alu_out, EN_ALU);
triState ts2 (data_bus, regOut_B, EN_B);
triState ts3 (data_bus, {32'b0,PC4}, EN_PC);
triState ts4 (addressLine, PC_out, EN_ADDR_PC);
defparam ts4.N = 32;
triState ts5 (addressLine, alu_out[31:0], EN_ADDR_ALU);
defparam ts5.N = 32;

endmodule