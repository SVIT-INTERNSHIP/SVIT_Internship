module tb;
reg A;
wire Y0, Y1;

decoder_1to2 d(A,Y0,Y1);

initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0,tb);
   
     A = 0; #10;
     A = 1; #10;
   
    $finish;
end
endmodule
