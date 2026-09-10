`timescale 1ns/1ps
module mp3_decoder_tb;
reg clk;
reg reset;
reg data_valid;
reg data_bit;
reg side_info_start;
reg [255:0] side_info;
reg ancillary_start;
reg ancillary_data_valid;
reg[7:0] ancillary_data_in;

wire [10:0] sync;
wire [1:0] version;
wire [1:0] layer;
wire protection;
wire [3:0] bitrate_index;
wire [1:0] sample_rate_index;
wire padding;
wire private_bit;
wire [1:0] channel_mode;
wire [1:0] mode_extension;
wire copyright_bit;
wire original;
wire [1:0] emphasis;

wire side_info_done;
wire side_info_error;
wire [8:0] main_data_begin;

wire [7:0] ancillary_data;
wire ancillary_valid;
wire ancillary_last;

wire signed [15:0] pcm_out;
wire pcm_valid;

mp3_decoder dut(
.clk(clk),
.reset(reset),
.data_valid(data_valid),
.data_bit(data_bit),
.side_info_start(side_info_start),
.side_info(side_info),
.ancillary_start(ancillary_start),
.ancillary_data_valid(ancillary_data_valid),
.ancillary_data_in(ancillary_data_in),
.sync(sync),
.version(version),
.layer(layer),
.protection(protection),
.bitrate_index(bitrate_index),
.sample_rate_index(sample_rate_index),
.padding(padding),
.private_bit(peivate_bit),
.channel_mode(channel_mode),
.mode_extension(mode_extension),
.copyright_bit(copyright_bit),
.original(original),
.emphasis(emphasis),
.side_info_done(side_info_done),
.side_info_error(side_info_error),
.main_data_begin(main_data_begin),
.ancillary_data(ancillary_data),
.ancillary_valid(ancillary_valid),
.ancillary_last(ancillary_last),

.pcm_out(pcm_out),
.pcm_valid(pcm_valid)
);

always #5 clk = ~clk;

task send_bit;
input b;
begin
@(negedge clk);
data_bit =b;
data_valid = 1'b1;
@(negedge clk);
data_valid = 1'b0;
end
endtask

task send_byte;
input [7:0] b;
integer i;
begin
for (i =7; i >= 0; i = i -1)
send_bit(b[i]);
end
endtask

initial begin
$dumpfile("mp3_decoder.vcd");
$dumpvars(0, mp3_decoder_tb);

clk = 1'b0;
reset = 1'b1;
data_valid = 1'b0;
data_bit = 1'b0;
side_info_start = 1'b0;
side_info = 256'd0;
ancillary_start = 1'b0;
ancillary_data_valid = 1'b0;
ancillary_data_in = 8'd0;

#20;
reset = 1'b0;


send_byte(8'hFF);

send_byte(8'hFB);
send_byte(8'h90);
send_byte(8'h64);

side_info = 256'd0;
@(negedge clk);
side_info_start = 1'b1;
@(negedge clk);
side_info_start = 1'b0;
#100;
send_byte(8'h01);
send_byte(8'h23);

#300;

$display("---------------");
$display("MP3 DECODER TEST");
$display("---------------");

$display("Header = %h", 32'hFFFB9064);
$display("Actual Header Data = %h", dut.header_data);
$display("Sync = %b", sync);
$display("Version = %b", version);
$display("Layer = %b", layer);
$display("Protection = %b", protection);
$display("Bitrate Index = %b", bitrate_index);
$display("Sample Rate Index = %b", sample_rate_index);
$display("Channel Mode = %b", channel_mode);

$display("Side Info Done = %b", side_info_done);
$display("Side Info Error = %b", side_info_error);

$display("PCM Valid = %b", pcm_valid);
$display("PCM Outout = %d", pcm_out);

$display("---------------");

#20;
$finish;

end

always@(posedge clk) begin
if (pcm_valid)
$display("Time=%0t : PCM = %d", $time, pcm_out);
end


always@(posedge clk) begin
if (side_info_done)
$display("Time=%0t : SIDE INFO DONE", $time);
end
endmodule
