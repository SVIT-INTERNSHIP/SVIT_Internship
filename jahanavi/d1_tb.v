module tb1;
reg a,en;
wire [1:0] y;
decoder_1to2 d1(a, en, y);
initial begin
$dumpfile("d1.vcd");
$dumpvars(0, tb1);
en=0; a=0; #10;
en=1; a=0; #10;
en=1; a=1; #10;
$finish;
end
endmodule
