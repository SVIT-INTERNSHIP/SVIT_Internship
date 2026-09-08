`timescale 1ns/1ps
module pcm_output_tb;
reg clk;
reg reset;
reg data_valid;
reg signed [15:0] sample_in;
wire signed [15:0] pcm_out;
wire pcm_valid;
pcm_output uut (.clk(clk), .reset(reset), .data_valid(data_valid), .sample_in(sample_in), .pcm_out(pcm_out), .pcm_valid(pcm_valid));
always #5 clk=~clk;
initial begin
	clk=0;
	reset=1;
	data_valid=0;
	sample_in=16'sd0;
	$dumpfile("pcm_output.vcd");
	$dumpvars(0,pcm_output_tb);
	#10;
	reset=0;
	#10;
	data_valid=1;
	sample_in=16'sd100;
	#10;
	data_valid=0;
	#10;
        data_valid=1;
        sample_in=-16'sd50;
        #10;
        data_valid=0;
	#10;
        data_valid=1;
        sample_in=16'sd200;
        #10;
        data_valid=0;
	#20;
	$display("====================================");
	$display("PCM OUTPUT TEST");
	$display("PCM_OUT=%d", pcm_out);
	$display("VALID=%b", pcm_valid);
	$display("====================================");
	#10;
	$finish;
end
endmodule

