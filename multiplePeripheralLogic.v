module multiplePeripheralLogic(data_bus, READ_IN, LOAD_OUT, LOAD_DIR, clock, reset, IO_0, IO_1, IO_2, IO_3, IO_4, IO_5, IO_6, IO_7, IO_8, IO_9, IO_10, IO_11, IO_12);
inout wire [63:0] data_bus;
input READ_IN;
input LOAD_OUT;
input LOAD_DIR;
input clock;
input reset;
inout IO_0, IO_1, IO_2, IO_3, IO_4, IO_5, IO_6, IO_7, IO_8, IO_9, IO_10, IO_11, IO_12;

singlePeripheralLogic P_0 (data_bus[0], READ_IN, LOAD_OUT, LOAD_DIR, IO_0, clock, reset); 
singlePeripheralLogic P_1 (data_bus[1], READ_IN, LOAD_OUT, LOAD_DIR, IO_1, clock, reset);
singlePeripheralLogic P_2 (data_bus[2], READ_IN, LOAD_OUT, LOAD_DIR, IO_2, clock, reset);
singlePeripheralLogic P_3 (data_bus[3], READ_IN, LOAD_OUT, LOAD_DIR, IO_3, clock, reset);
singlePeripheralLogic P_4 (data_bus[4], READ_IN, LOAD_OUT, LOAD_DIR, IO_4, clock, reset);
singlePeripheralLogic P_5 (data_bus[5], READ_IN, LOAD_OUT, LOAD_DIR, IO_5, clock, reset);
singlePeripheralLogic P_6 (data_bus[6], READ_IN, LOAD_OUT, LOAD_DIR, IO_6, clock, reset);
singlePeripheralLogic P_7 (data_bus[7], READ_IN, LOAD_OUT, LOAD_DIR, IO_7, clock, reset);
singlePeripheralLogic P_8 (data_bus[8], READ_IN, LOAD_OUT, LOAD_DIR, IO_8, clock, reset);
singlePeripheralLogic P_9 (data_bus[9], READ_IN, LOAD_OUT, LOAD_DIR, IO_9, clock, reset);
singlePeripheralLogic P_10(data_bus[10], READ_IN, LOAD_OUT, LOAD_DIR, IO_10, clock, reset);
singlePeripheralLogic P_11(data_bus[11], READ_IN, LOAD_OUT, LOAD_DIR, IO_11, clock, reset);
singlePeripheralLogic P_12(data_bus[12], READ_IN, LOAD_OUT, LOAD_DIR, IO_12, clock, reset);

endmodule