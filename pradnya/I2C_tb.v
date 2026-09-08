module tb_i2c_tx;

reg clk;
reg reset;
reg start;
reg scl;
reg[7:0]data;
wire sda;

i2c_tx i(
.reset(reset),
.start(start),
.scl(scl),
.data(data),
.sda(sda)
);

always #5 clk=~clk;

initial begin
$dumpfile("I2C.vcd");
$dumpvars(0, tb_i2c_tx);

clk=0;
reset=1;
start=0;
scl=0;
data=8'b10101010;

#20;
reset=0;

#20;
scl=1;
start=1;

#20;
scl=0;

#10;
start=0;

repeat(8) begin
#50;
scl=1;

#50;
scl=0;

end

#100;
$finish;
end
endmodule

