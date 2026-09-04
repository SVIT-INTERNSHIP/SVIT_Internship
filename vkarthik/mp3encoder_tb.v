module mp3_header_generator_tb;
reg      clk;
reg      rst_n;
reg      enable;
reg [1:0] mpeg_version;
reg [1:0] layer;
reg protection_not_set;
reg [3:0] bitrate_index;
reg [1:0] sampling_freq;
reg       padding_bit;
reg       private_bit;
reg [1:0] channel_mode;
reg [1:0] mode_extension;
reg       copyright;
reg       original;
reg [1:0] emphasis;
wire [31:0] header_out;
wire         valid_out;

mp3_header_generator  dut (

.clk(clk),
.rst_n(rst_n),
.enable(enable),
.mpeg_version(mpeg_version),
.layer(layer),
.protection_not_set(protection_not_set),
.bitrate_index(bitrate_index),
.sampling_freq(sampling_freq),
.padding_bit(padding_bit),
.private_bit(private_bit),
.channel_mode(channel_mode),
.mode_extension(mode_extension),
.copyright(copyright),
.original(original),
.emphasis(emphasis),

.header_out(header_out),
.valid_out(valid_out)
);

always #5 clk = ~clk;

initial begin

$dumpfile("mp3encoder.vcd");
$dumpvars(0, mp3_header_generator_tb);

clk   = 0;
rst_n  = 0;
enable = 1;
mpeg_version = 2'b11;
layer  = 2'b01;
protection_not_set = 1'b1;
bitrate_index = 4'b1110;
sampling_freq = 2'b1;
padding_bit = 1'b1;

private_bit = 1'b0;

channel_mode = 2'b11;
mode_extension = 2'b00;
copyright = 1'b0;

original = 1'b0;
emphasis = 2'b00;


#20;
rst_n = 1;

#10;
enable = 1;

#10;
enable = 0;

$display("Test case 1 Header Output: 0x%08X (Valid: %b)", header_out, valid_out);

#20;
bitrate_index = 4'b1110;
padding_bit = 1'b1;
channel_mode = 2'b11;
original =1'b0;
enable = 1;
#10;
enable = 0;
$display("Test case 2 Header Output: 0x%08X (valid: %b)",header_out, valid_out);
#30;
$finish;
end
endmodul
