module computer_withOutput(CLOCK_50, LEDG, GPIO0_D, GPIO1_D);
input CLOCK_50;
output [9:0] LEDG;
output [31:0] GPIO0_D;
inout [31:0] GPIO1_D;

wire [31:0]sw, led;
wire [31:0] sw_led;
wire clock; 
wire reset = 1'b0;
wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
wire HEX0_DP, HEX1_DP, HEX2_DP, HEX3_DP, HEX4_DP, HEX5_DP, HEX6_DP, HEX7_DP;
assign HEX0_DP = 1'b0;
assign HEX1_DP = 1'b0;
assign HEX2_DP = 1'b0;
assign HEX3_DP = 1'b0;
assign HEX4_DP = 1'b0;
assign HEX5_DP = 1'b0;
assign HEX6_DP = 1'b0;
assign HEX7_DP = 1'b0;

assign led[5:0] = 6'b101010;

clockDivider systemClock (CLOCK_50, clock);

computer(clock, reset, R0, R1, R2, R3, R4, R5, R6, R7);

GPIO_Board EXboard(
	CLOCK_50,
	R0, R1, R2, R3, R4, R5, R6, R7, 
	HEX0, HEX0_DP, HEX1, HEX1_DP, 
	HEX2, HEX2_DP, HEX3, HEX3_DP, 
	HEX4, HEX4_DP, HEX5, HEX5_DP, 
	HEX6, HEX6_DP, HEX7, HEX7_DP, sw, led, GPIO0_D, GPIO1_D);

assign LEDG[9] = clock;
assign LEDG[8:0] = R0[8:0];

endmodule