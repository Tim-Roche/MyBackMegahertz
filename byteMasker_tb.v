module byteMasker_tb();

reg [3:0] maskSize = 4'b0000;
wire [63:0] out;

byteMasker64 bm (maskSize, out);

initial begin
#10 maskSize = 4'b0001;
#10 maskSize = 4'b0010;
#10 maskSize = 4'b0011;
#10 maskSize = 4'b0100;
#10 maskSize = 4'b0101;
#10 maskSize = 4'b0110;
#10 maskSize = 4'b0111;
#10 maskSize = 4'b1000;
#10 maskSize = 4'b1001;
end



endmodule