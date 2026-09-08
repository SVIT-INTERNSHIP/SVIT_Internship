module mux8to1(input I0,input I1,input I2,input I3,input I4,input I5,input I6,input I7,input S0,input S1,input S2,output Y);
wire W0,W1;
mux4to1 MUX0(.I0(I0), .I1(I1), .I2(I2), .I3(I3), .S0(S0), .S1(S1), .Y(W0));
mux4to1 MUX1(.I0(I4), .I1(I5), .I2(I6), .I3(I7), .S0(S0), .S1(S1), .Y(W1));
mux2to1 MUX2(.I0(W0), .I1(W1), .S(S2), .Y(Y));
endmodule
