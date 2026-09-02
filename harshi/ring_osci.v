`timescale 1ns/1ps

module ring_osci(
     output reg n1,
     output reg n2,
     output reg n3
);

initial begin
    n1 = 0;
    n2 = 1;
    n3 = 0;
end

always #1 n1 = ~n3;
always #1 n2 = ~n1;
always #1 n3 = ~n2;

endmodule
