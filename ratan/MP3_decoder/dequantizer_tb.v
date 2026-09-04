`timescale 1ns/1ps
module dequantizer_tb;
reg clk;
reg reset;
reg data_valid;
reg signed [3:0] x_in;
reg signed [3:0] y_in;
wire signed [15:0] x_out;
wire signed [15:0] y_out;
wire output_valid;
dequantizer uut (.clk(clk), .reset(reset), .data_valid(data_valid), .x_in(x_in), .y_in(y_in), .x_out(x_out), .y_out(y_out), .output_valid(output_valid));
always #5 clk=~clk;
initial begin
	clk=0;
	reset=1;
	data_valid=0;
	x_in=0;
	y_in=0;
	#10;
	reset=0;
	#10;
	data_valid=1;
	x_in=2;
	y_in=3;
	#10;
	data_valid=0;
	#20;
	$display("==============================");
	$display("DEQUANTIZER TEST");
	$display("X_OUT=%d", x_out);
	$display("Y_OUT=%d", y_out);
	$display("VALID=%d", output_valid);
	$display("==============================");
	$dumpfile("dequantizer.vcd");
	$dumpvars(0,dequantizer_tb);
	#20;
	$finish;
end
endmodule
