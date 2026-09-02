module counter_tb;
reg clk;
reg reset;
wire [3:0] count;
counter c1(
.clk(clk),
.reset(reset),
.count(count)
);
initial begin
$dumpfile("counter.vcd");
$dumpvars(0, counter_tb);
clk =0;
reset =1;
#10;
reset =0;
#100;
$finish;
end
always #5 clk = ~clk;
endmodule
