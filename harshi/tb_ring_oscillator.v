`timescale 1ns/1ps

module tb_ring_oscillator;

wire n1,n2,n3;

ring_oscillator uut(
   .n1(n1),
   .n2(n2),
   .n3(n3)
);

initial begin
   $dumpfile("ring_oscillator.vcd");
   $dumpvars(0, tb_ring_oscillator);

   force n1 = 1'b0;
   #2;
   release n1;

   #48;
   $finish;
end

initial begin
   $monitor("Time = %0t ns: n1 = %b  n2 = %b  n3 = %b",
            $time, n1, n2, n3);

  
end

endmodule
