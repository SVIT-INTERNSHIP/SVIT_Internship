
module fifo_tb;
reg clk;
reg reset;
reg write_en;
reg read_en;
reg [7:0] data_in;
wire [7:0] data_out;
wire empty;
wire full;

fifo uut(
.clk(clk),
.reset(reset),
.write_en(write_en),
.read_en(read_en),
.data_in(data_in),
.data_out(data_out),
.empty(empty),
.full(full)
);

always #5 clk = ~clk;

initial begin

clk=0;
reset=1;
write_en=0;
read_en=0;
data_in=8'd0;

#10;
$dumpfile("fifo.vcd");
$dumpvars(0, fifo_tb);
reset=0;

write_en=1;
data_in=8'd10;
#10;
data_in=8'd20;
#10;
data_in=8'd30;
#10;
data_in=8'd40;
#10;
write_en=0;
read_en=1;
#10;
#10;
#10;
#10;
read_en=0;
write_en=1;
data_in=8'd50;
#10;
data_in=8'd60;
#10;

write_en=0;
write_en=1;
read_en=1;

data_in=8'd70;
#10;
write_en=0;
read_en=0;
#20;
$finish;
end

initial begin
$monitor(
"TIME=%0t WRITE=%b READ=%b DATA_IN=%d DATA_OUT=%d COUNT=%d EMPTY=%b",$time, 
write_en,
read_en,
data_in,
data_out,
uut.count,
empty,
full
);
end
endmodule
