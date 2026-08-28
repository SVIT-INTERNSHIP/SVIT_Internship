module tb_mux4;
reg d0,d1,d2,d3;
reg [1:0]s;
wire y;

mux4to1 uut (d0,d1,d2,d3,s,y);
initial begin 
$dumpfile("dump4.vcd");
$dumpvars(0,tb_mux4);
d0=0;d1=1;d2=0;d3=1;
s=0;#10;
s=1;#10;
s=2;#10;
s=3;#10;
$finish;
end 
endmodule

