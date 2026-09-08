module encoder_tb;
reg [3:0] d;
wire [1:0] y;
encoder uut (.d(d), .y(y));
initial begin
	$monitor("Time=%0t d=%b y=%b", $time, d, y);
	d=4'b0001;
	#10 d=4'b0010;
	#10 d=4'b0100;
	#10 d=4'b1000;
	#10 $finish;
end
endmodule
