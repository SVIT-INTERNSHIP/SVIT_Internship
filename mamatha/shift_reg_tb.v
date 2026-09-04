module shift_reg_tb;
reg clk,reset,dir,serial_in;
wire [7:0]q;
shift_reg uut(.clk(clk),
.reset(reset),
.dir(dir),
.serial_in(serial_in),
.q(q));

always #5 clk=~clk;
initial
begin
$monitor("Time=%0t | RESET=%b | DIR=%b | SERIAL_IN=%b | Q=%b",$time,reset,dir,serial_in,q);
$dumpfile("shift_reg.vcd");
$dumpvars(0,shift_reg_tb);
clk=0;
reset=1;
dir=1;
serial_in=0;
#10 reset=0;
#10;
serial_in=1;#10;
serial_in=0;#10;
serial_in=1;#10;
serial_in=1;#10;
#10 dir=0;
serial_in=0;#10;
serial_in=0;#10;
serial_in=0;#10;

 $finish;

end
initial
begin
end
endmodule


