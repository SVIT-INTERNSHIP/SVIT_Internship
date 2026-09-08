module hsync_vga_tb;
reg clk;
reg reset;
wire hsync;
hsync_vga uut(
.clk(clk),
.reset(reset),
.hsync(hsync));

always 
#1 clk=~clk;
initial begin
$dumpfile("hsync.vcd");
$dumpvars(0,hsync_vga_tb);
clk=0;
reset=1;
#10;
reset=0;
#2000;
$finish;
end 
endmodule
