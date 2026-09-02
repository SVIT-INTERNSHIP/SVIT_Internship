module orgate_tb;
reg A,B;
wire Y;
orgate uut(
.A(A),
.B(B),
.Y(Y)
);
initial begin
$dumpfile("orgate.vcd");
$dumpvars(0, orgate_tb);
$monitor("A=%b B=%b Y=%b",A,B,Y);
A = 0; B = 0;
#10 A = 0; B = 1; 
#10 A = 1; B = 0;
#10 A = 1; B = 1;
#10 $finish;
end
endmodule

