`timescale 1ns/1ps
module fourbit_tb;
reg [3:0]A,B;
reg Cin;
wire [3:0]Sum;
wire Cout;

fourbit uut(
.A(A),
.B(B),
.Cin(Cin),
.Sum(Sum),
.Cout(Cout)
);
initial begin 
$dumpfile("fourbit.vcd");
$dumpvars(0,fourbit_tb);
A = 4'b0000; B = 4'b0000; Cin = 0;
#10 A = 4'b0011; B = 4'b0001; Cin = 0;
#10 A = 4'b0111; B = 4'b0001; Cin = 0;
#10 A = 4'b1111; B = 4'b0001; Cin = 0;
#10 A = 4'b1010; B = 4'b0101; Cin = 1;
#10 A = 4'b0110; B = 4'b0011; Cin = 0;
#10 $finish;
end
endmodule

