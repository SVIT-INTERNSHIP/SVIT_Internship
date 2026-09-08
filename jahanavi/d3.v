module decoder_3to8(
input [2:0] a,
input en,
output [7:0] y
);
wire [3:0] w;
decoder_2to4 d0(a[2:1],en,w);
assign y[0] = w[0] & ~a[0];
assign y[1] = w[0] & a[0];

assign y[2] = w[1] & ~a[0];
assign y[3] = w[1] & a[0];

assign y[4] = w[2] & ~a[0];
assign y[5] = w[2] & a[0];

assign y[6] = w[3] & ~a[0];
assign y[7] = w[3] & a[0];
endmodule
