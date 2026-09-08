module dac_8bit(
 input wire [7:0] digital_in,
 output reg [7:0] analog_out
 );

 always @(*)begin
  analog_out=digital_in;
 end

endmodule
