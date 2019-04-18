module peripheralLogic_TB();
wire [3:0] data_bus = 4'b1010;
wire [3:0] IO;
reg READ_IN = 1'b0;
reg LOAD_OUT = 1'b0;
reg LOAD_DIR = 1'b0;
reg clock = 1'b0;
reg reset = 1'b0; 


peripheralLogic pl (data_bus, IO, READ_IN, LOAD_OUT, LOAD_DIR, clock, reset);
defparam pl.N = 4;

wire [3:0] sendQ = pl.sendQ;

always begin
 #5; clock = ~clock;
end

initial begin
	LOAD_OUT = 1'b1;
	LOAD_DIR = 1'b1;
	#20
	#10 $stop;
end

endmodule