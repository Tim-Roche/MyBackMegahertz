module computer_withOutput(CLOCK_50, LEDG);
input CLOCK_50;
output [9:0] LEDG;

wire clock; 
wire reset = 1'b0;
wire [15:0] r0;

clockDivider systemClock (CLOCK_50, clock);

computer(clock, reset, r0);

assign LEDG[9] = clock;
assign LEDG[8:0] = r0[8:0];

endmodule