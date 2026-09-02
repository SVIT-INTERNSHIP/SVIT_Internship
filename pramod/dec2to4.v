module dec2to4(input e,a,b, output [3:0] y);
wire [1:0] W;
dec1to2 D0(e,a,W);
dec1to2 D1(W[0],b,y[1:0]);
dec1to2 D2(W[1],b,y[3:2]);
endmodule
