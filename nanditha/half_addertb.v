module half_addertb;
reg A,B;
wire SUM, CARRY;
half_adder dut(
.A(A),
.B(B),
.SUM(SUM),
.CARRY(CARRY)
);
initial begin
$dumpfile("half_adder.vcd");
$dumpvars(0, half_addertb);

A = 0; B = 0;
#10 A = 0; B = 1;
#10 A = 1; B = 0;
#10 A = 1; B = 1;
#10 $finish;
end
endmodule
