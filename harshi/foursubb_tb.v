'timescale 1ns/1ps

module foursubb_tb;

reg [3:0] a;
reg [3:0] b;
reg bin;

wire[3:0] diff;
wire bout;

foursubb uut(a,b,bin,diff,bout);

initial begin

$dumpfile("foursubb.vcd");
$dumpvars(0,foursubb_tb);

a=4'b0101;
b=4'b0011;
bin=0;
#10;

a=4'b1000;
b=4'b0011;
bin=0;
#10;

a=4'b1111;
b=4'b0001;
bin=0;
#10;

a=4'b1010;
b=4'b0101;
bin=1;
#10;
a=4'b0000
b=4'b0001;
bin=0;
#10;

$finish;

end

initial begin
$monitor("a=%b b=%b bin=%b diff=%b bout=%b",
      a,b,bin,diff,bout);

end

endmodule
