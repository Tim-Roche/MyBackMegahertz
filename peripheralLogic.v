module peripheralLogic(data_bus, out, READ_IN, LOAD_OUT, LOAD_DIR, clock, reset);
parameter N = 64;
inout [N-1:0] data_bus;
inout [N-1:0] out;
input READ_IN;
input LOAD_OUT;
input LOAD_DIR;
input clock;
input reset; 

wire [N-1:0] storeOut;
wire [N-1:0] data_bus;
wire [N-1:0] out; 
wire [N-1:0] triEnables;
wire [N-1:0] sendQ;
wire [N-1:0] toStore;

triState storeTri (data_bus, storeOut, READ_IN);
defparam storeTri.N = N;

bitwiseTristate sendTri(sendQ, out, triEnables);
defparam sendTri.N = N;

RegisterNbit storeReg (storeOut, out, 1'b1, reset, clock);
defparam storeReg.N = N;

RegisterNbit sendReg (sendQ, data_bus, LOAD_OUT, reset, clock);
defparam sendReg.N = N;

RegisterNbit loadReg (triEnables, data_bus, LOAD_DIR, reset, clock);
defparam loadReg.N = N;

endmodule