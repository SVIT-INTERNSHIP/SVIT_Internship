module mp3_header_decoder(
input [31:0] header,
output [10:0] sync,
output [1:0] version,
output [1:0] layer,
output protection,
output [3:0] bitrate_index,
output [1:0] sample_rate_index,
output padding,
output private_bit,
output [1:0] channel_mode,
output [1:0] mode_extension,
output copyright_bit,
output original,
output [1:0] emphasis
);
assign sync =header [31:21];
assign version =header [20:19];
assign layer =header [18:17];
assign protection =header [16];
assign bitrate_index =header [15:12];
assign sample_rate_index =header [11:10];
assign padding =header [9];
assign private_bit =header [8];
assign channel_mode =header [7:6];
assign mode_extension =header [5:4];
assign copyright_bit =header [3];
assign original =header [2];
assign emphasis =header [1:0];
endmodule
