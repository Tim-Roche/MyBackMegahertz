module multiplePeripheralLogic(data_bus, CS, mem_read, mem_write, LOAD_DIR, clock, reset, IO_0, IO_1, IO_2, IO_3, IO_4, IO_5, IO_6, IO_7, IO_8, IO_9, IO_10, IO_11, IO_12);
inout [63:0] data_bus;
input mem_read;
input mem_write;
input LOAD_DIR;
input clock;
input reset;
input CS;
inout IO_0, IO_1, IO_2, IO_3, IO_4, IO_5, IO_6, IO_7, IO_8, IO_9, IO_10, IO_11, IO_12;
wire [12:0] periOut;

wire [63:0] data_bus = (CS&mem_read&~mem_write&~LOAD_DIR) ? {51'd0, periOut} : 64'dz;

singlePeripheralLogic P_0 (data_bus[0], mem_read, mem_write, LOAD_DIR, periOut[0], IO_0, clock, reset); 
singlePeripheralLogic P_1 (data_bus[1], mem_read, mem_write, LOAD_DIR, periOut[1], IO_1, clock, reset); 
singlePeripheralLogic P_2 (data_bus[2], mem_read, mem_write, LOAD_DIR, periOut[2], IO_2, clock, reset); 
singlePeripheralLogic P_3 (data_bus[3], mem_read, mem_write, LOAD_DIR, periOut[3], IO_3, clock, reset); 
singlePeripheralLogic P_4 (data_bus[4], mem_read, mem_write, LOAD_DIR, periOut[4], IO_4, clock, reset); 
singlePeripheralLogic P_5 (data_bus[5], mem_read, mem_write, LOAD_DIR, periOut[5], IO_5, clock, reset); 
singlePeripheralLogic P_6 (data_bus[6], mem_read, mem_write, LOAD_DIR, periOut[6], IO_6, clock, reset); 
singlePeripheralLogic P_7 (data_bus[7], mem_read, mem_write, LOAD_DIR, periOut[7], IO_7, clock, reset); 
singlePeripheralLogic P_8 (data_bus[8], mem_read, mem_write, LOAD_DIR, periOut[8], IO_8, clock, reset); 
singlePeripheralLogic P_9 (data_bus[9], mem_read, mem_write, LOAD_DIR, periOut[9], IO_9, clock, reset); 
singlePeripheralLogic P_10(data_bus[10], mem_read, mem_write, LOAD_DIR, periOut[10], IO_10, clock, reset); 
singlePeripheralLogic P_11(data_bus[11], mem_read, mem_write, LOAD_DIR, periOut[11], IO_11, clock, reset); 
singlePeripheralLogic P_12(data_bus[12], mem_read, mem_write, LOAD_DIR, periOut[12], IO_12, clock, reset); 

endmodule