module full4_tb;
reg [3:0] A,B;
reg Bin;
wire [3:0] Difference;
wire Borrow;
full4 uut( .A(A), .B(B), .Bin(Bin), .Difference(Difference), .Borrow(Borrow));
initial begin
	$dumpfile("full4.vcd");
	$dumpvars(0, full4_tb);
	A = 4'b0000; B=4'b0000; Bin=1'b0;
       #10  A = 4'b0101; B=4'b0011; Bin=1'b0;
	#10 A = 4'b0110; B=4'b0011; Bin=1'b1;
	#10 A = 4'b0011; B=4'b0101; Bin=1'b0;
	#10 A = 4'b1111; B=4'b0001; Bin=1'b1;
	#10 $finish;
end
endmodule
