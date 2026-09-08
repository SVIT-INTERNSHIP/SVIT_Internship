module mp3_header_generator (
	input [1:0] mpeg_version,
	input [1:0] layer,
	input       protection_bit,
	input [3:0] bitrate_index,
	input [1:0] sample_rate_index,
	input       padding_bit,
	input       private_bit,
	input [1:0] channel_mode,
	input [1:0] mode_extension,	
	input       copyright_bit,
	input       original_bit,
	input [1:0] emphasis,
	
	output [31:0] mp3_header
);
     assign mp3_header = {
	11'b11111111111,
	mpeg_version,
	layer,
	protection_bit,
	bitrate_index,
        sample_rate_index,
	padding_bit,
	private_bit,
	channel_mode,
	mode_extension,
	copyright_bit,
        original_bit,
	emphasis};
endmodule
	
