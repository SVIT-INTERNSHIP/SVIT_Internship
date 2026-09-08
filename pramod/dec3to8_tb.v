module dec3to8_tb;
 reg e;
 reg [2:0]a;
 wire [7:0]y;

 dec3to8 uut (.e(e),.a(a),.y(y));

 initial begin
 $dumpfile("dec3to8.vcd");
 $dumpvars(0,dec3to8_tb);

e=0;a=3'b000;#10;
e=1;a=3'b000;#10;
e=1;a=3'b001;#10;
e=1;a=3'b010;#10;
e=1;a=3'b011;#10;
e=1;a=3'b100;#10;
e=1;a=3'b101;#10;
e=1;a=3'b110;#10;
e=1;a=3'b111;#10;
$finish;
end
endmodule

