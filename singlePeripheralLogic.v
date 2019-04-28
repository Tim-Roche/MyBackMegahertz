module singlePeripheralLogic(data_bus, mem_read, mem_write, LOAD_DIR, storeOut, IO, clock, reset);
input data_bus;
input mem_read;
input mem_write;
input LOAD_DIR;
input clock;
input reset;
inout IO;
output storeOut;
wire storeOut;
wire data_bus;
wire triEnable;
wire sendQ;

wire IO = (triEnable) ? sendQ : 1'bz;
wire inIO = (~triEnable) ? IO : 1'b0;

                    //(Q,        D,     L,  R,    clock)
RegisterNbit storeReg (storeOut, inIO, 1'b1, reset, clock);
defparam storeReg.N = 1;

RegisterNbit sendReg (sendQ, data_bus, mem_write, reset, clock);
defparam sendReg.N = 1;

RegisterNbit loadReg (triEnable, data_bus, LOAD_DIR, reset, clock);
defparam loadReg.N = 1;

triState storeTri (data_bus, storeOut, mem_read);
defparam storeTri.N = 1;

endmodule