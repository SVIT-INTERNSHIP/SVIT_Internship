module tb_mux8;
reg d0,d1,d2,d3,d4,d5,d6,d7,d8;
reg [2:0]s;
wire y;
mux8to1 uut(d0,d1,d2,d3,d4,d5,d6,d7,s,y);
initial begin
$dumpfile("dump8.vcd");
$dumpvars(0,tb_mux8);
d0=0;d1=1;d2=0;d3=1;d4=0;d5=1;d6=0;d7=1;
s=0;#10;s=1;#10;s=2;#10;s=3;#10;
s=4;#10;s=5;#10;s=6;#10;s=7;#10;
$finish;
end
endmodule

