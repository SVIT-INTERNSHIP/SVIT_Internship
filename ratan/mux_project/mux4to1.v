module mux4to1(input I0,input I1,input I2,input I3,input S0,input S1,output Y);
wire W0,W1;
mux2to1 MUX0(.I0(I0), .I1(I1), .S(S0), .Y(W0));
mux2to1 MUX1(.I0(I2), .I1(I3), .S(S0), .Y(W1));
mux2to1 MUX2(.I0(W0), .I1(W1), .S(S1), .Y(Y));
endmodule  

