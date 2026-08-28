module tb_mux2;
reg d0,d1,s;
wire y;

mux2is1 uut(d0,d1,s,y);
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,tb_mux2);
d0=0;d1=1;
s=0;#10;
s=1;#10;
$finish;
end
endmodule

