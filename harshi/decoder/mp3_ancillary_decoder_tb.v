`timescale 1ns/1ps

module mp3_ancillary_decoder_tb;

reg clk;
reg reset;
reg start_frame;
reg data_valid;
reg [7:0] data_in;

wire [7:0] ancillary_data;
wire ancillary_valid;
wire ancillary_last;

integer i;

mp3_ancillary_decoder DUT(
  .clk(clk),
  .reset(reset), 
  .start_frame(start_frame),
  .data_valid(data_valid),
  .data_in(data_in),
  .ancillary_data(ancillary_data),
  .ancillary_valid(ancillary_valid),
  .ancillary_last(ancillary_last)
);

always #5 clk = ~clk;

initial begin

  clk = 1'b0;
  reset = 1'b1;
  start_frame =1'b0;
  data_valid = 1'b0;
  data_in = 8'h00;
 
  #10;

  reset = 1'b0;

  @(negedge clk);

  start_frame = 1'b1;
  data_valid = 1'b1;
  data_in = 8'h00;

  @(negedge clk);

  start_frame = 1'b0;

  for (i = 1; i < 417; i = i + 1) begin
       data_in = i;
       @(negedge clk);
  end

  data_valid = 1'b0;

  #20;

  $finish;

 end

 initial begin
 
     $dumpfile("mp3_ancillary_decoder.vcd");
     $dumpvars(0, mp3_ancillary_decoder_tb);
 end

endmodule
