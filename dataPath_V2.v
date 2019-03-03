module dataPath_V2(r0, r1, r2, r3, r4, r5, r6, r7, data_bus, k, FS, B_Sel, EN_B, EN_ALU, EN_ADDR_ALU, ram_cs, ram_write_en, ram_read_en, w_reg, reset_reg, ramOutsize, clock, SA, SB, DA, C0);
input [63:0] k;
input [4:0] FS;
input B_Sel;
input EN_B;
input EN_ADDR_ALU;
input EN_ALU;
input w_reg;
input reset_reg;
input clock;
input C0;
input ram_cs;
input ram_write_en;
input ram_read_en;
input [1:0] ramOutsize;
input [4:0] SA, SB, DA;
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 
output [63:0] data_bus;

wire[63:0] regOut_A, regOut_B;
wire[63:0] alu_out;
wire[63:0] muxOut;
wire [31:0] addressLine;
				  	          //A,              B, SA, SB,        D, DA,     W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7
RegisterFile32x64 regFile(regOut_A, regOut_B, SA, SB, data_bus, DA, w_reg, reset_reg, clock, r0, r1, r2, r3, r4, r5, r6, r7);

		            //F, S, I0, I1
mux2to1_64bit mux(muxOut, B_Sel, regOut_B, k);

		         //A, B, FS, C0, F, status
ALU_LEGv8 alu (regOut_A, muxOut, FS, C0, alu_out, status);
				 //clk, address, data, cs, we, oe
//ram_sp_sr_sw ram (clock, addressLine, data_bus, ram_cs, ram_write_en, ram_read_en); 
RAM_64bit ram(clock, addressLine, data_bus, ram_cs, ram_write_en, ram_read_en, ramOutsize);

triState ts1 (data_bus, alu_out, EN_ALU);
triState ts2 (data_bus, regOut_B, EN_B);
triState ts3 (addressLine, alu_out[31:0], EN_ADDR_ALU);
defparam ts3.N = 32;

endmodule