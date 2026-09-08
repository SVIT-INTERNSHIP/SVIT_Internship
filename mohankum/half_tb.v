module half_tb;
reg A,B;
wire Difference,Borrow;
half uut(.A(A), .B(B), .Difference(Difference), .Borrow(Borrow));
initial begin
	$dumpfile("half.vcd");
	$dumpvars(0, half_tb);
	A = 0; B = 0;
	#10 A=0; B=1;
	#10 A=1; B=0;
	#10 A=1; B=1;
	#10 $finish;
end
endmodule
