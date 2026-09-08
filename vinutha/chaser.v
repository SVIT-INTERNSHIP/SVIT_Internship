module led_chaser(
 input clk,
 input reset,
 output reg[3:0]leds
);

always @(posedge clk or posedge reset)begin
 if (reset)begin
  leds<=4'b0001;
 end else begin
  leds<={leds[2:0],leds[3]};
 end
end

endmodule
