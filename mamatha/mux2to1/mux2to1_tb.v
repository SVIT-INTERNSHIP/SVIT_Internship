module mux2to1_tb;
reg i0,i1,s;
wire y;
mux2to1 uut(
.i0(i0),
.i1(i1),
.s(s),
.y(y));
initial begin
$dumpfile("mux2to1.vcd");
$dumpvars(0,mux2to1_tb);
$monitor("i0=%b i1=%b s=%b y=%b",i0,i1,s,y);
i0=0;i1=0;s=0;#10;
i0=0;i1=1;s=0;#10;
i0=1;i1=0;s=0;#10;
i0=1;i1=1;s=0;#10;

i0=0;i1=0;s=1;#10;
i0=0;i1=1;s=1;#10;
i0=1;i1=0;s=1;#10;
i0=1;i1=1;s=1;#10;
$finish;
end
endmodule



