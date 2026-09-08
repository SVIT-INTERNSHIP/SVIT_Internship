module i2c_master_tx_tb;
reg clk;
reg rst_n;
reg tx_start;
reg [7:0] tx_data;
reg scl;
wire sda;
wire tx_busy;
wire tx_done;
i2c_master_tx dut(
.clk(clk),
.rst_n(rst_n),
.tx_start(tx_start),
.tx_data(tx_data),
.scl(scl),
.sda(sda),
.tx_busy(tx_busy),
.tx_done(tx_done)
);
pullup(sda);
initial
begin
clk=1'b0;
forever #5 clk=~clk;
end
initial
begin
scl=1'b1;
forever begin
#10 scl=1'b0;
#10 scl=1'b1;
end
end

initial begin
$dumpfile("i2c_master_tx.vcd");
$dumpvars(0,i2c_master_tx_tb);

rst_n=1'b0;
tx_start=1'b0;
tx_data=8'h00;
#25;
rst_n=1'b1;
@(negedge scl);
tx_data =8'hA5;
tx_start=1'b1;
@(negedge scl);
tx_start=1'b0;
wait(tx_done);
#20;

$display("------------------------");
$display("First transmission completed");
$display("TX DATA=0x%02h",tx_data);
$display("------------------------");
#20;
$finish;
end
always@(posedge scl) begin
if(tx_busy) begin
$display("TIME=%-t SDA=%b SHIFT_REG=%b BIT_COUNT=%0d",
$time,sda,dut.tx_shift_reg,dut.bit_count);
end
end
endmodule

