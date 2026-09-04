`timescale 1ns/1ps
module main_data_extractor_tb;
reg clk;
reg reset;
reg data_valid;
reg data_bit;
reg [8:0] main_data_begin;
wire main_data_valid;
wire [31:0] main_data;
main_data_extractor uut (.clk(clk), .reset(reset), .data_valid(data_valid), .data_bit(data_bit), .main_data_begin(main_data_begin), .main_data_valid(main_data_valid), .main_data(main_data));
always #5 clk=~clk;
initial begin
	$display("==============================");
	$display("MAIN DATA EXTRACTION TEST");
	$display("==============================");
	clk=0;
	reset=1;
	data_valid=0;
	data_bit=0;
	main_data_begin=9'd0;
	#20;
	reset=0;
	data_valid=1;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=1; #10;

	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=0; #10;
	data_bit=1; #10;

	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=1; #10;
	data_bit=0; #10;

	data_bit=1; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=0; #10;
	data_bit=1; #10;
	data_bit=1; #10;
	
	data_valid=0;
	#20;
	$display("main_data=%h",main_data);
	$display("Valid=%b",main_data_valid);
	$display("============================");
	$dumpfile("main_data.vcd");
	$dumpvars(0,main_data_extractor_tb);
	#10;
	$finish;
end
endmodule
