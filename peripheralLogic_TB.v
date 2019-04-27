module peripheralLogic_TB();
wire [3:0] data_bus;
wire [3:0] IO = 4'b1010;
reg READ_IN = 1'b0;
reg LOAD_OUT = 1'b0;
reg LOAD_DIR = 1'b0;
reg clock = 1'b0;
reg reset = 1'b1; 


peripheralLogic pl (data_bus, IO, READ_IN, LOAD_OUT, LOAD_DIR, clock, reset);
defparam pl.N = 4;

wire [3:0] sendQ = pl.sendQ;

always begin
 #5; clock = ~clock;
end

initial begin
	#5 reset = 0;
	READ_IN = 1'b1;
	#20
	#10 $stop;
end

endmodule