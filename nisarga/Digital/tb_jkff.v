module jk_ff_tb;
reg clk;
reg rst;
reg j;
reg k;
wire q;

jk_ff uut(
.clk(clk),
.rst(rst),
.j(j),
.k(k),
.q(q)
);

always #5 clk = ~clk;

initial begin
$dumpfile("jk_ff.vcd");
$dumpvars(0,jk_ff_tb);
$monitor("Time=%0t | J=%b K=%b | Q=%b", $time, j, k,q);

clk=0;
rst=1;
j=0;
k=0;

#10 rst=0;
#10 j=0; k=0;
#10 j=0; k=1;
#10 j=1; k=0;
#10 j=1; k=1;
#20 $finish;
end
endmodule

