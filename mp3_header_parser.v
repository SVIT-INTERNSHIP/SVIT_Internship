`timescale 1ns/1ps
module mp3_header_parser (input [31:0] header,output reg [10:0] sync,output reg [1:0] mpeg_version,
output reg [1:0] layer,output reg protection,output reg [3:0] bitrate_index,output reg [1:0] sample_frequency_index,output reg padding,output reg private_bit,output reg [1:0] channel_mode,output reg [1:0] mode_extension,output reg copyright_bit,output reg original_bit,output reg [1:0] emphasis);
always @(*) begin
	sync=header[31:21];
	mpeg_version=header[20:19];
	layer=header[18:17];
	protection=header[16];
	bitrate_index=header[15:12];
	sample_frequency_index=header[11:10];
	padding=header[9];
	private_bit=header[8];
	channel_mode=header[7:6];
	mode_extension=header[5:4];
	copyright_bit=header[3];
	original_bit=header[2];
	emphasis=header[1:0];
end
endmodule
