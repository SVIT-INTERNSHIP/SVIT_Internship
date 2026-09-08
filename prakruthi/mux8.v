module mux8to1 (input d0,d1,d2,d3,d4,d5,d6,d7, input [2:0]s,output y);
wire w0,w1;
mux4to1 u1 (d0,d1,d2,d3,s[1:0],w0);
mux4to1 u2 (d4,d5,d6,d7,s[1:0],w1);
mux2is1 u3 (w0,w1,s[2],y);
endmodule

