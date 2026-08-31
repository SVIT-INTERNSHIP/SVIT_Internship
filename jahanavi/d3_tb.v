module tb3;
reg [2:0] a;
reg en;
wire [7:0]y;
decoder_3to8 d3(a,en,y);
initial begin
$dumpfile("d3.vcd");
$dumpvars(0, tb3);
en=0; a=3'b000; #10;
en=1; a=3'b000; #10;
en=1; a=3'b001; #10;
en=1; a=3'b010; #10;
en=1; a=3'b011; #10;
en=1; a=3'b100; #10;
en=1; a=3'b101; #10;
en=1; a=3'b110; #10;
en=1; a=3'b111; #10;
$finish;
end
endmodule
