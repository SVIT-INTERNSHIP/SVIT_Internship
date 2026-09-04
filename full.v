module full(A,B,Bin,Difference,Borrow);
input A,B,Bin;
output Difference, Borrow;
wire D1,B1,B2;
half H1(.A(A), .B(B), .Difference(D1), .Borrow(B1));
half H2(.A(D1), .B(Bin), .Difference(Difference), .Borrow(B2));
assign Borrow = B1 | B2;
endmodule
