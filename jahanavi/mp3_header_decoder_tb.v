module mp3_header_decoder_tb;
reg [31:0] header;
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

mp3_header_decoder dut(
.header(header),
.sync(sync),
.version(version),
.layer(layer),
.protection(protection),
.bitrate_index(bitrate_index),
.sample_rate_index(sample_rate_index),
.padding(padding),
.private_bit(private_bit),
.channel_mode(channel_mode),
.mode_extension(mode_extension),
.copyright_bit(copyright_bit),
.original(original),
.emphasis(emphasis)
);
initial begin
$dumpfile("mp3_header.vcd");
$dumpvars(0, mp3_header_decoder_tb);

header =32'hFFFB9064;
#10;

$display("Sync =%b",sync);
$display("Version =%b",version);
$display("Layer =%b", layer);
$display("Protection =%b", protection);
$display("Bitrate Index =%b", bitrate_index);
$display("Sample Rate Index =%b", sample_rate_index);
$display("Padding =%b", padding);
$display("Private Bit =%b", private_bit);
$display("Channel Mode =%b", channel_mode);
$display("mode extension =%b", mode_extension);
$display("Copyright =%b", copyright_bit);
$display("Original =%b", original);
$display("Emphasis =%b", emphasis);
$finish;
end
endmodule
