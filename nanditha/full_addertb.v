`timescale 1ns/1ps
module full_addertb;
reg A,B,Cin;
wire Sum,Cout;
full_adder uut(
.A(A),
.B(B),
.Cin(Cin),
.Sum(Sum),
.Carry(Cout)
);

initial begin
$dumpfile("full_adder.vcd");
$dumpvars(0, full_addertb);

A = 0; B = 0; Cin = 0;
#10 A = 0; B = 0; Cin = 1;
#10 A = 0; B = 1; Cin = 0;
#10 A = 0; B = 1; Cin = 1;
#10 A = 1; B = 0; Cin = 0;
#10 A = 1; B = 0; Cin = 1;
#10 A = 1; B = 1; Cin = 0;
#10 A = 1; B = 1; Cin = 1;
end
endmodule 




