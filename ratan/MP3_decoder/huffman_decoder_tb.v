`timescale 1ns/1ps
module huffman_decoder_tb;
reg clk;
reg reset;
reg data_valid;
reg data_bit;
wire decide_valid;
wire signed [3:0] x;
wire signed [3:0] y;
huffman_decoder uut (.clk(clk), .reset(reset), .data_valid(data_valid), .data_bit(data_bit), .decode_valid(decode_valid), .x(x), .y(y));
always #5 clk=~clk;
reg [23:0] test_data;
integer i;
initial begin
clk=0;
reset=1;
data_valid=0;
data_bit=0;
#10;
reset=0;
test_data=24'b000000010010001101000101;
for(i=23;i>=0;i=i-1) begin
#10;
data_valid=1;
data_bit=test_data[i];
end
#10;
data_valid=0;
#20;
$display("==================================");
$display("HUFFMAN DECODER TEST");
$display("X=%d",x);
$display("Y=%d",y);
$display("Valid=%b",decode_valid);
$display("==================================");
$dumpfile("huffman.vcd");
$dumpvars(0,huffman_decoder_tb);
#20;
$finish;
end
endmodule

