module counter_tb;
reg clk;
reg reset;
reg enable;
reg up_down;
wire [3:0] count;
counter DUT(.clk(clk), .reset(reset), .enable(enable), .up_down(up_down), .count(count));
always #5 clk=~clk;
initial begin
	$dumpfile("counter.vcd");
	$dumpvars(0,counter_tb);
	$monitor("Time=%0t | Reset=%b Enable=%b Up_Down=%b |Count=%d",$time,reset,enable,up_down,count);
	clk=0;
	reset=1;
	enable=0;
	up_down=1;
	#10 reset=0;
	enable=1;
	up_down=1;
	#80 up_down=0;
	#50 enable=0;
	#20 reset=1;
	#10 $finish;
end
endmodule
