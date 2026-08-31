module counter8_tb;
reg clk, reset, load, up_down;
reg [7:0] data_in;
wire [7:0] count;

counter8 uut(
.clk(clk),
.reset(reset),
.load(load),
.up_down(up_down),
.data_in(data_in),
.count(count)
);

always #5 clk = ~clk;

initial begin
clk = 0;
reset = 1;
load = 0;
up_down = 1;
data_in = 0;

#10 reset = 0;
load = 1;
data_in = 8'd10;
#10;

load = 0;
up_down = 1;
#40;
 up_down = 0;
#40;

$finish;
end

initial begin
$monitor("Timer=%0t Count=%d", $time, count);
end

initial begin
$dumpfile("counter8.vcd");
$dumpvars(0, counter8_tb);
end
endmodule
