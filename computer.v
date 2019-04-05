module computer(clock,reset);
input clock;
input reset; 

wire [35:0] controlWord;
wire [31:0] k;
wire [31:0] IR;
wire [3:0] status;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 
wire [31:0] mem_address;
wire [63:0] mem_data;
wire mem_cs, mem_write_en, mem_read;
wire [1:0] size; 

controlUnit cu(clock, reset, IR, status, controlWord, k);

datapath   dp (clock, reset, controlWord, k, status, IR, mem_data, mem_address, r0, r1, r2, r3, r4, r5, r6, r7);

RAM_64bit ram (clock, mem_address, mem_data, mem_cs, mem_write_en, mem_read, size);
defparam ram.ADDR_WIDTH = 16;

ROM   prgmMem (mem_address, mem_data, chip_select, output_enable); 

endmodule