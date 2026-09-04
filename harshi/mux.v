module mux4to1(
       input i0,
       input i1,
       input i2,
       input i3,
       input s0,
       input s1,
       output y
);

assign y = (~s1 & ~s0 & i0) |
           (~s1 &  s0 & i1) |
           ( s1 & ~s0 & i2) |
           ( s1 &  s0 & i3);
endmodule
