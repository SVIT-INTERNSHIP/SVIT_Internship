module register_bank_tb;

reg clk;
reg we;
reg [2:0] addr;
reg [7:0] din;
wire [7:0] dout;

register_bank uut(
.clk(clk),
.we(we),
.addr(addr),
.din(din),
.dout(dout)
);

always #5 clk = ~clk;

initial begin
$dumpfile("register_bank.vcd");
$dumpvars(0, register_bank_tb);

clk=0; 
we=1;

addr=3'b000;
din=8'd25;
#10;

addr = 3'b011;
din = 8'd50;
#10;

addr = 3'b111;
din = 8'd100;
#10;

we = 0;
addr = 3'b000;
#10;

addr = 3'b011;
#10;

addr = 3'b111;
#10;

$finish;
end
endmodule
