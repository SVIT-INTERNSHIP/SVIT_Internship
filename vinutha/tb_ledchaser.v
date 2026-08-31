module tb_ledchaser;

reg clk;
reg reset;
wire [3:0]leds;

led_chaser uut(
 .clk(clk),
 .reset(reset),
 .leds(leds)
);

always #5 clk=~clk;

initial begin
 clk=0;
 reset=1;
$dumpfile("chaser.vcd");
$dumpvars(0,tb_ledchaser);

 $monitor("time=%3d ns | reset=%b | leds: [%b %b %b%b]",
$time,reset,leds[3],leds[2],leds[1],leds[0]);

 #12 reset=0;
 #80 $finish;

end

endmodule

