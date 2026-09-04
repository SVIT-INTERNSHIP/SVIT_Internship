`timescale 1ns/1ps
module side_info_parser_tb;
reg clk;
reg reset;
reg data_valid;
reg data_bit;
wire side_info_valid;
wire [8:0] main_data_begin;
wire [2:0] private_bits;
wire [11:0] part2_3_length;
wire [8:0] big_values;
side_info_parser uut (.clk(clk), .reset(reset), .data_valid(data_valid), .data_bit(data_bit), .side_info_valid(side_info_valid), .main_data_begin(main_data_begin), .private_bits(private_bits), .part2_3_length(part2_3_length), .big_values(big_values));
always #5 clk=~clk;
reg [33:0] test_data;
integer i;
initial begin
	clk=0;
	reset=1;
	data_valid=0;
	data_bit=0;
	#10;
	reset=0;
	test_data=34'b101010101_101_000011001100_001100110;
	for (i=33;i>=0;i=i-1) begin
	#10;
	data_valid=1;
	data_bit=test_data[i];
end
#10;
data_valid=0;
#20;
$display("SIDE INFORMATION PARSER TEST");
$display("main data begin=%d",main_data_begin);
$display("private bits=%b",private_bits);
$display("part2_3 length=%d",part2_3_length);
$display("Big Values=%d",big_values);
$display("Valid=%b",side_info_valid);
$display("================================");
$dumpfile("side_info.vcd");
$dumpvars(0,side_info_parser_tb);
#20;
$finish;
end
endmodule
