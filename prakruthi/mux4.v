module mux4to1(input d0,d1,d2,d3, input [1:0]s, output y);
wire w0,w1;
mux2is1 u1 (d0,d1,s[0],w0);
mux2is1 u2 (d2,d3,s[0],w1);
mux2is1 u3 (w0,w1,s[1],y);
endmodule
