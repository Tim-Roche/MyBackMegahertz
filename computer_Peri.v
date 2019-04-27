module computer_Peri(CLOCK_50, LEDG, GPIO0_D, GPIO1_D, SW);
input CLOCK_50;
input [9:0] SW;
output [9:0] LEDG;
output [31:0] GPIO0_D;
inout [31:0] GPIO1_D;

wire clock; 
wire P_CLOCK, P_DATA, P_CS;

wire reset = 1'b0;
wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;

clockDivider systemClock (CLOCK_50, clock);

computer comp (clock, reset, R0, R1, R2, R3, R4, R5, R6, R7, P_CLOCK, P_DATA, P_CS, SW[9], SW[8], SW[7], SW[6], SW[5], SW[4], SW[3], SW[2], SW[1], SW[0]);

assign LEDG[2:0] = {P_CS, P_DATA, P_CLOCK};
assign LEDG[9] = clock;

assign GPIO1_D[0] = P_CLOCK;
assign GPIO1_D[1] = P_DATA;
assign GPIO1_D[3] = P_CS;



endmodule