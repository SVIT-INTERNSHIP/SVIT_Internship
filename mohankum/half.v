module half(A,B,Difference,Borrow);
input A,B;
output Difference, Borrow;
assign Difference = A^B;
assign Borrow = (~A)&B;
endmodule
