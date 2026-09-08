module decoder_2to4(
input [1:0] a,
input en,
output [3:0] y
);
wire [1:0] w;
decoder_1to2 d0(a[1], en, w);
decoder_1to2 d1(a[0], w[0], y[1:0]);
decoder_1to2 d2(a[0], w[1], y[3:2]);
endmodule

