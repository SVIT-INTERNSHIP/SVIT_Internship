
module rgb_tb;
reg [9:0] x;
reg [9:0] y;

wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;

rgb uut (.x(x), .y(y), .red(red), .green(green), .blue(blue));
initial begin
	$dumpfile("rgb.vcd");
	$dumpvars(0,rgb_tb);
	x=100;
	y=100;
	#10;
	
	x=300;
	y=100;
	#10;

	x=500;
	y=100;
	#10;
	
	x=700;
	y=500;
	#10;

	$finish;
end
endmodule

