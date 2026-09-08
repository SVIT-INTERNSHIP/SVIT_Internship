module dec1to2(input E,S, output [1:0] Y);
assign Y[0] = E & ~S;
assign Y[1] = E & S;
endmodule
