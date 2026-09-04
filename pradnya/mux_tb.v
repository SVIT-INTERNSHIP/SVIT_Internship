module mux_tb;

reg a,b,s;
wire y;

mux
 m1(a,b,s,y);

initial begin
$dumpfile("mux.vcd");
$dumpvars(0, mux_tb);

a=0; b=0; s=0;
#10 a=1; b=0; s=0;
#10 a=0; b=1; s=1;
#10 a=1; b=1; s=1;

#10 $finish;
end

initial begin 
$monitor("a=%b b=%b s=%b y=%b", a, b, s, y);
end
endmodule

