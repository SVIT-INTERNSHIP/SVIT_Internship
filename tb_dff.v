module tb_dff;
reg d;
reg clk;
wire q;

dff uut (
	.d(d),
	.clk(clk),
	.q(q)
);
initial begin
	$dumpfile("dff.vcd");
	$dumpvars(0,tb_dff);

	clk = 0;
	d = 0;

	#10 d = 1;
	#10 d = 0;
	#10 d = 1;
	#10 d = 0;
	
	#10 $finish;
end
always #5 clk = ~clk;
initial begin
	$monitor("Time=%0t d=%b clk=%b q=%b", $time, d,clk,q);
end
endmodule
