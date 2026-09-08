`timescale 1ns / 1ns
module i2c_tb_master();
reg clk;
reg rst_n;
reg rx_enable;
reg sda_drive;
wire scl;
wire [7:0] rx_reg;
wire done;

reg [7:0] test_data = 8'b10110101;
integer i;

i2c_master uut (
.clk(clk),
.rst_n(rst_n),
.rx_enable(rx_enable),
.sda(sda_drive),
.scl(scl),
.rx_reg(rx_reg),
.done(done)
);

always #10 clk = ~clk;

initial begin
$dumpfile("I2C_tb.vcd");
$dumpvars(0, i2c_tb_master);

$monitor("Time=%0t ns | rst_n=%b | rx_enable=%b | scl=%b | sda=%b | bit_cnt=%d | rx_reg=8'b%b (0x%h) | done=%b",
$time, rst_n, rx_enable, scl, sda_drive, uut.bit_cnt, rx_reg, done);
end

task simulate_slave_tx(input [7:0] data);
begin
for (i = 7; i >= 0; i = i - 1) begin
@(negedge scl);
sda_drive = data[i];
end
end
endtask

initial begin

clk = 1'b0;
rst_n = 1'b0;
rx_enable = 1'b0;
sda_drive = 1'b1;

#100;
rst_n = 1'b1;
#40;

$display("[%0t ns] Triggering Master...", $time);
rx_enable = 1'b1;
#20;
rx_enable = 1'b0;

simulate_slave_tx(test_data);

@(posedge done);
$display("[%0t ns] Read Complete!", $time);
$display("Transmitted Data: %b (0x%h)", test_data, test_data);
$display("Received Data: %b (0x%h)", rx_reg, rx_reg);

if (rx_reg === test_data) begin
$display("SUCCESS: RX Register accurately captured SDA data.");
end
else begin
$display("ERROR: Data mismatche!");
end

#200;
$finish;
end

endmodule
