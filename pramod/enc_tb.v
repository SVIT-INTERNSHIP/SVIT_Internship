module tb;
reg clk=0,rst=1,v=0,f=0; reg[3:0]pcm=0; wire out_v; wire[7:0]b_out; wire[5:0]cnt;
enc DUT (clk,rst,v,f,pcm,out_v,b_out,cnt);
always #5 clk=~clk;
initial begin
$dumpfile("enc.vcd");
$dumpvars(0, tb);
$monitor("T=%0t | v=%b f=%b pcm=%d | out_v=%b byte=0x%h bits=%0d",
$time,v,f,pcm,out_v,b_out,cnt);
#10 rst=0; repeat(5) begin @(posedge clk); v<=1; pcm<=3; end
@(posedge clk); v<=0; f<=1; @(posedge clk); f<=0; #20 $finish;
end
endmodule
