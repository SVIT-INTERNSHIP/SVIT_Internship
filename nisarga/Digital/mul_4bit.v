module mul_4bit(
input [3:0] A,
input [3:0] B,
output [7:0] P
);

wire [15:0] partial;

multiplier_1bit m0 (A[0],B[0],partial[0]);
multiplier_1bit m1 (A[1],B[0],partial[1]);
multiplier_1bit m2 (A[2],B[0],partial[2]);
multiplier_1bit m3 (A[3],B[0],partial[3]);

multiplier_1bit m4 (A[0],B[1],partial[4]);
multiplier_1bit m5 (A[1],B[1],partial[5]);
multiplier_1bit m6 (A[2],B[1],partial[6]);
multiplier_1bit m7 (A[3],B[1],partial[7]);

multiplier_1bit m8 (A[0],B[2],partial[8]);
multiplier_1bit m9 (A[1],B[2],partial[9]);
multiplier_1bit m10 (A[2],B[2],partial[10]);
multiplier_1bit m11 (A[3],B[2],partial[11]);

multiplier_1bit m12 (A[0],B[3],partial[12]);
multiplier_1bit m13 (A[1],B[3],partial[13]);
multiplier_1bit m14 (A[2],B[3],partial[14]);
multiplier_1bit m15 (A[3],B[3],partial[15]);

assign P=partial[3:0]
        +(partial[7:4]<<1)
        +(partial[11:8]<<2)
        +(partial[15:12]<<3);
endmodule
