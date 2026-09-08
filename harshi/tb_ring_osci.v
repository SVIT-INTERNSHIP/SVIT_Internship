`timescale 1ns/1ps

module tb_ring_osci;

wire n1, n2, n3;

ring_osci uut(
   .n1(n1),
   .n2(n2),
   .n3(n3)
);

initial begin
     $dumpfile("ring_osci.vcd");
     $dumpvars(0, tb_ring_osci);

     $monitor("Time=%0t n1=%b n2=%b n3=%b",
              $time, n1, n2, n3);
     #50;
     $finish;
end

endmodule
