`timescale 1ns/1ps

module ring_oscillator(
     output n1,
     output n2,
     output n3
);

not #(1) G1(n1, n3);
not #(1) G2(n2, n1);
not #(1) G3(n3, n2);

endmodule

