module registerfile_tb;
reg clk;
reg reset;
reg write_enable;
reg [3:0]write_addr;
reg [7:0]write_data;
reg [3:0]read_addr;
wire [7:0]read_data;

registerfile uut(
.clk(clk),
.reset(reset),
.write_enable(write_enable),
.write_addr(write_addr),
.write_data(write_data),
.read_addr(read_addr),
.read_data(read_data)
);

always #5 clk = ~clk;
initial
begin
$dumpfile("registerfile.vcd");
$dumpvars(0,registerfile_tb);
end

initial begin
clk=0;
reset=1;
write_enable=0;
write_addr=0;
write_data=0;
read_addr=0;

#10;
reset=0;

write_enable=1;
write_addr=4'd0;
write_data=8'd55;
#10;

write_addr=4'd5;
write_data=8'd100;
#10;

write_addr=4'd10;
write_data=8'd200;
#10;

write_enable=0;

read_addr=4'd0;
#10;
$display("Register 0=%d",read_data);

read_addr=4'd5;
#10;
$display("Register 5=%d",read_data);

read_addr=4'd10;
#10;
$display("Register 10=%d",read_data);

read_addr=4'd15;
#10;
$display("Register 15=%d",read_data);

$finish;
end
endmodule

