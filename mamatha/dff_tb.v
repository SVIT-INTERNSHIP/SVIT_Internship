module dff_tb;
reg D,clk,set,reset;
wire q;
dff uut(.D(D),
.clk(clk),
.set(set),
.reset(reset),
.q(q));
always 
#5 clk=~clk;
initial
begin
$dumpfile("dff.vcd");
$dumpvars(0,dff_tb);
clk=0;
D=0;
set=0;
reset=0;
#10 D=1;
#10 D=0;
#10 set=1;
#10 set=0;
#10 reset=1;
#10 reset=0;
#10 D=1;
#10 $finish;
end
initial
begin
$monitor("Time=%0t | D=%b | clk=%b | q=%b | SET=%b | RESET=%b",$time,D,clk,q,set,reset);
end
endmodule
