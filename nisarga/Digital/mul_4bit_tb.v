module mul_4bit_tb;
reg [3:0] A;
reg [3:0] B;
wire [7:0] P;

mul_4bit uut(
.A(A),
.B(B),
.P(P)
);

initial begin
$dumpfile("mul_4bit.vcd");
$dumpvars(0,mul_4bit_tb);
end

initial begin
A=4'b0000;B=4'b0000;
#10;

A=4'b0010;B=4'b0011;
#10;

A=4'b0101;B=4'b0011;
#10;

A=4'b1111;B=4'b0010;
#10;

A=4'b1111;B=4'b1111;
#10;

$finish;

end

initial begin
$monitor("Time=%0t | A=%b | B=%b | P=%b",$time,A,B,P);
end
endmodule
