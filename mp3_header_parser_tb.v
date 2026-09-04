`timescale 1ns/1ps
module mp3_header_parser_tb;
	reg [31:0] header;
	wire [10:0] sync;
	wire [1:0] mpeg_version;
	wire [1:0] layer;
	wire protection;
	wire [3:0] bitrate_index;
	wire [1:0] sample_frequency_index;
	wire padding;
	wire private_bit;
	wire [1:0] channel_mode;
	wire [1:0] mode_extension;
	wire copyright_bit;
	wire original_bit;
	wire [1:0] emphasis;
	mp3_header_parser DUT (.header(header), .sync(sync), .mpeg_version(mpeg_version), .layer(layer), .protection(protection), .bitrate_index(bitrate_index), .sample_frequency_index(sample_frequency_index), .padding(padding), .private_bit(private_bit), .copyright_bit(copyright_bit), .emphasis(emphasis));
initial begin
	$dumpfile("header.vcd");
	$dumpvars(0,mp3_header_parser_tb);
	//MPEG-1 layer 111 example header
	header=32'b11111111111110111001000000000000;
	#10;
	$display("================================");
	$display("      MP3 HEADER PARSER TEST");
	$display("================================");
	$display("Header=%b",header);
	$display("SYNC=%b",sync);
	$display("MPEG Version=%b",mpeg_version);
	$display("Layer=%b",layer);
	$display("Protection=%b",protection);
	$display("Bitrate index=%b",bitrate_index);
	$display("Sample Frequency Index=%b",sample_frequency_index);
	$display("Padding=%b",padding);
	$display("Private Bit=%b",private_bit);
	$display("Channel Mode=%b",channel_mode);
	$display("Mode Extension=%b",mode_extension);
	$display("Copyright=%b",copyright_bit);
	$display("Original=%b",original_bit);
	$display("Emphasis=%b",emphasis);
	$display("================================");
	$finish;
end
endmodule

