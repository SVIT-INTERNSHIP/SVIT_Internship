module decoder_1to2(
input A,
input EN,
output Y0,
output Y1
);

assign Y0 = EN & ~A;
assign Y1 = EN & A;

endmodule
