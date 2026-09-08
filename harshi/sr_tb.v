module tb_sr_flipflop;

reg s, r, clk;
wire q;

sr_flipflop uut (
        .s(s),
        .r(r),
        .clk(clk),
        .q(q)
);

initial begin
     clk = 0;
     forever #5 clk = ~clk;
end

initial begin
   $dumpfile("sr_flipflop.vcd");
   $dumpvars(0, tb_sr_flipflop);

    s = 0; r = 0;
    #10 s = 1; r = 0;
    #10 s = 0; r = 1;
    #10 s = 0; r = 0;
    #10 s = 1; r = 1;
    #10 s = 0; r = 0;
    #10 $finish;
end

initial begin
 
          $monitor("s=%b r=%b clk=%b | q=%b",  s, r, clk, q);
end
endmodule 
