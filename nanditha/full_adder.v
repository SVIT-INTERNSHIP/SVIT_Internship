module full_adder(
input A,
input B,
input Cin,
output Sum,
output Carry
);
wire S1;
wire C1;
wire C2;
half_adder HA1(
.A(A),
.B(B),
.SUM(S1),
.CARRY(C1)
);
half_adder HA2(
.A(S1),
.B(Cin),
.SUM(Sum),
.CARRY(C2)
);
assign Carry = C1|C2;
endmodule
