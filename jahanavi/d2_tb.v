module tb2;
reg [1:0] a;
reg en;
wire [3:0] y;
decoder_2to4 d2(a,en,y);
initial begin
$dumpfile("d2.vcd");
$dumpvars(0, tb2);
en=0; a=2'b00; #10;
en=1; a=2'b00; #10;
en=1; a=2'b01; #10;
en=1; a=2'b10; #10;
en=1; a=2'b11; #10;
$finish;
end
endmodule
