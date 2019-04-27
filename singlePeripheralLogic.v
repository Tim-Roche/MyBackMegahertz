module singlePeripheralLogic(data_bus, READ_IN, LOAD_OUT, LOAD_DIR, IO, clock, reset);
inout data_bus;
input READ_IN;
input LOAD_OUT;
input LOAD_DIR;
input clock;
input reset;
inout IO;

wire storeOut;
wire data_bus;
wire triEnable;
wire sendQ;
wire toStore;

RegisterNbit storeReg (storeOut, IO, 1'b1, reset, clock);
defparam storeReg.N = 1;

RegisterNbit sendReg (sendQ, data_bus, LOAD_OUT, reset, clock);
defparam sendReg.N = 1;

RegisterNbit loadReg (triEnable, data_bus, LOAD_DIR, reset, clock);
defparam loadReg.N = 1;

triState sendTri (IO, sendQ, triEnable);
defparam sendTri.N = 1;

triState storeTri (data_bus, storeOut, READ_IN);
defparam storeTri.N = 1;

endmodule