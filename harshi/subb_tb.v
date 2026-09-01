module tb_full_subtractor;
reg a,b,bin;
wire d, bout;
full_subtractor uut(
.a(a),
.b(b),
.bin(bin),
.d(d),
.bout(bout)
);

initial begin
$dumpfile("subtractor.vcd");
$dumpvars(0,tb_full_subtractor);

a=0; b=0; bin=0;
#10 a=0; b=0; bin=1;
#10 a=0; b=1; bin=0;
#10 a=0; b=1; bin=1;
#10 a=1; b=0; bin=0;
#10 a=1; b=0; bin=1;
#10 a=1; b=1; bin=0;
#10 a=1; b=1; bin=1;

#10 $finish;
end

initial begin
$monitor("a=%b b=%b bin=%b | d=%b bout=%b",a,b,bin,d,bout);
end
endmodule
