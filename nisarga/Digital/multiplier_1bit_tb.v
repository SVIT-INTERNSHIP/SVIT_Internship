module multiplier_1bit_tb;
reg A;
reg B;
wire P;

multiplier_1bit uut(
.A(A),
.B(B),
.P(P)
);

initial begin
$dumpfile("multiplier_1bit.vcd");
$dumpvars(0, multiplier_1bit_tb);
end

initial begin 
A=0;B=0;
#10;

A=0;B=1;
#10;

A=1;B=0;
#10;

A=1;B=1;
#10;
$finish;
end

initial begin
$monitor("Time=%0t A=%b B=%b P=%b",$time,A,B,P);

end 
endmodule
