module computer(clock,reset, r0, r1, r2, r3, r4, r5, r6, r7);
input clock;
input reset;
output [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 

parameter CUL = 35;

parameter GPIO_DIR_ADDRESS = 32'd254;
parameter GPIO_RW_ADDRESS = 32'd255;

wire [CUL:0] controlWord;
wire [4:0] SA;
wire [4:0] SB;
wire [4:0] DA;
wire w_reg;
wire C0;
wire [1:0] mem_cs;
wire B_Sel;
wire mem_write_en;
wire IR_load;
wire status_load;
wire [1:0] size;
wire add_tri_sel;
wire [1:0] data_tri_sel;
wire PC_sel;
wire [1:0] PC_FS;
wire [4:0] FS;
wire [63:0] mem_data;
wire [31:0] mem_address;
wire [63:0] P_OUT;

wire mem_read = (data_tri_sel == 2'b11) ? 1'b1 : 1'b0;

assign {FS, SA, SB, DA, w_reg, C0, mem_cs, B_Sel, mem_write_en, IR_load, status_load, size, add_tri_sel, data_tri_sel, PC_sel, PC_FS} = controlWord;

wire [63:0] k;
wire [31:0] IR;
wire [3:0] status;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 
wire [31:0] pc_out;

controlUnit cu (clock, reset, IR, status, controlWord, k);
//           (clock, reset, controlWord, k, status, IR, data_bus, addressLine, r0, r1, r2, r3, r4, r5, r6, r7)
datapath  dp (clock, reset, controlWord, k, status, IR, mem_data, mem_address, r0, r1, r2, r3, r4, r5, r6, r7, pc_out);

wire GPIO_DIR = (mem_address == GPIO_DIR_ADDRESS) ? 1'b1 : 1'b0;
wire GPIO_RW  = (mem_address == GPIO_RW_ADDRESS)  ? 1'b1 : 1'b0;
wire PERI_select = GPIO_DIR|GPIO_RW;

wire RAM_select = mem_cs[0]&~PERI_select;
wire ROM_select = ~mem_cs[0]&~PERI_select;

RAM_64bit ram (clock, mem_address[11:0], mem_data, RAM_select, mem_write_en, mem_read, size);
defparam ram.ADDR_WIDTH = 12;

ROM  prgmMem (mem_address, mem_data, ROM_select, mem_read); 

wire P_READ_IN = GPIO_RW&mem_read;
wire P_LOAD_OUT = GPIO_RW&mem_write_en;
wire P_LOAD_DIR = GPIO_DIR;

peripheralLogic pl (mem_data, P_OUT, P_READ_IN, P_LOAD_OUT, P_LOAD_DIR, clock, reset);

endmodule