module i2c_master_tb;
localparam CLK_DIV = 4;
reg clk;
reg rst_n;
reg start_i;
reg [6:0] slave_addr;
reg rw;
wire scl;
wire sda;
wire busy;
wire done;

reg slave_ack_drive;
assign sda = slave_ack_drive ? 1'b0 : 1'bz;

pullup (sda);

i2c_master #(.CLK_DIV(CLK_DIV)) DUT (
.clk (clk), .rst_n (rst_n), .start_i (start_i), 
.slave_addr (slave_addr), .rw (rw), .scl (scl), .sda (sda), 
.busy (busy), .done(done));
always #5 clk = ~clk;
reg [7:0] captured;
integer bitcnt;
reg start_seen, stop_seen, ack_sent;

initial begin
clk = 1'b0;
rst_n = 1'b0;
start_i = 1'b0;
slave_addr = 7'h55;
rw = 1'b0;
slave_ack_drive = 1'b0;
captured = 8'h00;
bitcnt = 0;
start_seen = 1'b0;
stop_seen = 1'b0;
ack_sent = 1'b0;

#20 rst_n = 1'b1;
#20 start_i = 1'b1;
#20 start_i = 1'b0;
end

always @(negedge sda)
if (scl) begin 
start_seen = 1'b1;
$display("[%0t ns] START condition detected (SDA fell while SCL high)", $time);
end

always @(posedge sda)
if (scl) begin
stop_seen = 1'b1; 
$display("[%0t ns] STOP condition detected (SDA rose while SCL high)", $time);
end

always @(posedge scl) begin
if (start_seen && bitcnt < 8) begin
captured = {captured[6:0], sda};
bitcnt = bitcnt + 1;
$display("[%0t ns] Sampled bit %0d -> sda = %b", 
$time, bitcnt, sda);
end 
end

always @(negedge scl) begin
if (bitcnt == 8 && !ack_sent) begin
slave_ack_drive <= 1'b1;
ack_sent <= 1'b1;

end else if (ack_sent) begin
slave_ack_drive <= 1'b0;
end
end

initial begin
$dumpfile("i2c_master_tb.vcd");
$dumpvars(0, i2c_master_tb);
end

initial begin 
#2000;
if (start_seen && stop_seen && (captured == {slave_addr,rw}))
$display("\nTest PASSED : captured addr+rw = %b, expected = %b", 
captured, {slave_addr, rw});
else
$display("\nTest FAILED : captured addr+rw = %b, expected = %b, start_seen=%b, stop_seen=%b", captured, 
{slave_addr, rw}, start_seen, stop_seen);
$finish;
end
endmodule








