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
wire STATE0 = (state == 3'b000);
wire STATE1 = (state == 3'b001);
wire status_zero;

wire PC_HOLD = STATE0&CBZ;
wire PC_PLUS4 = STATE1&CBZ&~status_zero;
wire PC_JUMP = STATE1&CBZ&status_zero;
wire PC_IN = 1'b0;

wire status_load  = (CBZ&STATE0);
assign PC = PC_HOLD  ? 2'b00 : 
				PC_PLUS4 ? 2'b01 :
				PC_IN    ? 2'b10 : 2'b11;
assign NS = ((CBZ|BL)&STATE0) ? 3'b001 : 3'b000;
assign SA = (CBZ&STATE0) ? 5'd31 : SA_in;

endmodule