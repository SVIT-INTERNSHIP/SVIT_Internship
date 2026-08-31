module register_file_tb;
reg clk;
reg reset;
reg write_enable;
reg [3:0]write_addr;
reg [7:0]write_data;
reg [3:0]read_addr;
wire [7:0]read_data;

register_file uut(
.clk(clk),
.reset(reset),
.write_enable(write_enable),
.write_addr(write_addr),
.write_data(write_data),
.read_addr(read_addr),
.read_data(read_data)
);
always #5 clk=~clk;
initial
begin
$dumpfile("register_file.vcd");
$dumpvars(0,register_file_tb);

clk=0;
reset=1;
write_enable=0;
write_addr=0;
write_data=0;
read_addr=0;
#10 reset=0;
write_enable=1;
write_addr=4'b0000;
write_data=8'b10101010;
#10;

write_addr=4'b0101;
write_data=8'b11001100;
#10;

write_addr=4'b1010;
write_data=8'b11110000;
#10;

write_enable=0;
read_addr=4'b0000;
#5;
read_addr=4'b0101;
#5;
read_addr=4'b1010;
#5;
read_addr=4'b1111;
#5;
$finish;
end
endmodule










