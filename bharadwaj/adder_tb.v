module adder_tb;
reg [3:0] A;
reg [3:0] B;
wire [4:0] SUM;

adder uut (
.A(A),
.B(B),
.SUM(SUM)
);

initial begin
$dumpfile("adder.vcd");
$dumpvars(0, adder_tb);
A = 4'b0011;
B = 4'b0010;
#10;
$display("A = %d, B = %d, SUM = %d", A, B, SUM);

A = 4'b0101;
B = 4'b0011;
#10;
$display("A = %d, B = %d, SUM = %d", A, B, SUM);

A = 4'b1111;
B = 4'b0001;
#10;
$display("A = %d, B= %d, SUM = %d", A, B, SUM);
$finish;
end
endmodule
