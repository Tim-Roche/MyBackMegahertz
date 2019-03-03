module triState(out, in, enable);
parameter N = 64;
input [N-1:0] in;
input enable;
output [N-1:0] out;

assign out = enable ? in : {N{1'bz}};

endmodule