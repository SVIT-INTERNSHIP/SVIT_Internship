
module tb;
reg E,A,B;
wire [3:0] Y;
dec2to4 DUT(E,A,B,Y);
initial begin 
  $dumpfile("dec2to4.vcd");
  $dumpvars(0,tb);

  E = 0; A = 0; B = 0; #10;
  E = 1; A = 0; B = 0; #10;
  B = 1; #10;
  A = 1; B = 0; #10;
  B = 1; #10;
  $finish;
end
endmodule
