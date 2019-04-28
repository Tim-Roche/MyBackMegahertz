module computer_Peri(CLOCK_50, LEDG, GPIO0_D, GPIO1_D);
input CLOCK_50;
output [9:0] LEDG;
output [31:0] GPIO0_D;
inout [31:0] GPIO1_D;

wire clock; 
wire reset = 1'b0;
wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
wire [63:0] P_OUT;
wire P_CLOCK = P_OUT[0];
wire P_DATA = P_OUT[1];
wire P_CS = P_OUT[2];

assign LEDG[2:0] = {P_CS, P_DATA, P_CLOCK};
assign LEDG[7:4] = R4; 
assign LEDG[9] = clock;



assign GPIO1_D[0] = P_CLOCK;
assign GPIO1_D[1] = P_DATA;
assign GPIO1_D[3] = P_CS;

clockDivider systemClock (CLOCK_50, clock);

computer comp (clock, reset, R0, R1, R2, R3, R4, R5, R6, R7, P_OUT);

endmodule