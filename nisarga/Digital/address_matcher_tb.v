

module address_matcher_tb;
reg clk;
reg reset;
reg [6:0] received_addr;
reg check_addr_flag;
wire ack_bit;

i2c_slave_ip uut(
.clk(clk),
.reset(reset),
.received_addr(received_addr),
.check_addr_flag(check_addr_flag),
.ack_bit(ack_bit)
);

always #5 clk = ~clk;
initial begin
clk = 0;
reset = 1;
received_addr = 7'b0000000;
check_addr_flag = 1;

$dumpfile("address_matcher.vcd");
$dumpvars(0, address_matcher_tb);
#10;
reset=0;

received_addr=7'b1010101;
#10;

received_addr=7'b1111111;
#10;

check_addr_flag=0;
#10;
$finish;
end

initial begin
$monitor(
"TIME=%0t | RECEIVED_ADDR=%b | CHECK=%b | ACK=%b",
$time,
received_addr,
check_addr_flag,
ack_bit
);
end
endmodule
