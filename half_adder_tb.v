module half_adder_tb;
reg A, B;
wire Sum, Carry;

half_adder uut (
    .A(A),
    .B(B),
    .Sum(Sum),
    .Carry(Carry)
);

initial begin
    $dumpfile("half_adder.vcd");
    $dumpvars(0, half_adder_tb);
    A = 0; B = 0;
    #10 A = 0; B = 1;
    #10 A = 1; B = 0;
    #10 A = 1; B = 1;
    #10 $finish;
end

initial begin
    $monitor("Time=%0t A=%b B=%b Sum=%b Carry=%b", $time, A, B, Sum, Carry);
end
endmodule

