module full_tb;
reg A,B,Bin;
wire Difference, Borrow;
full uut( A,B,Bin, Difference,Borrow);
initial begin
	$dumpfile("full.vcd");
	$dumpvars(0, full_tb);
	A=0; B=0; Bin=0;
	#10 A=0; B=0; Bin=1;
	#10 A=0; B=1; Bin=0;
	#10 A=0; B=1; Bin=1;
	#10 A=1; B=0; Bin=0;
	#10 A=1; B=0; Bin=1;
	#10 A=1; B=1; Bin=0;
	#10 A=1; B=1; Bin=1;
	#10 $finish;
end
endmodule
