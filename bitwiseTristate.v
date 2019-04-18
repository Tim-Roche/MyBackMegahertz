module bitwiseTristate(in, out, enables);
parameter N = 64;
input [N-1:0] in;
input [N-1:0] enables;
output [N-1:0] out;

wire [N-1:0] in;
wire [N-1:0] enables;
reg [N-1:0] out;

integer i;
always @(*) begin
  for (i = 0; i < N; i = i + 1) begin  
    if (enables[i] == 1'b1) begin
		out[i] <= in[i];
	 end
	 else begin
		out[i] <= 1'bz;
    end
	end
end

endmodule