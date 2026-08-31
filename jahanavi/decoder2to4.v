module decoder_2to4(
input [1:0] A,
input EN,
output [3:0] Y
);

wire E0, E1;

decoder_1to2 do(A[1], EN, E0, E1);
decoder_1to2 d1(A[0], E0, Y[0], Y[1]);
decoder_1to2 d2(A[0], E1, Y[2], Y[3]);

endmodule
