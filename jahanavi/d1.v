module decoder_1to2(
input a,
input en,
output [1:0] y
);

assign y[0] = en & ~a;
assign y[1] = en & a;

endmodule
