module decoder_tb;
reg a,b;
wire [3:0] y;
decoder uut (.a(a), .b(b), .y(y));
initial begin
	$dumpfile("decoder.vcd");
	$dumpvars(0, decoder_tb);
	$monitor("Time=%0t a=%b b=%b y=%b", $time, a, b, y);
	a=0; b=0;
	#10 a=0; b=1;
	#10 a=1; b=0;
	#10 a=1; b=1;
	#10 $finish;
end
endmodule
