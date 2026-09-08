 module tb_mp3_header_generator;
	
	reg [1:0] mpeg_version, layer;
        reg protection_bit;
        reg [3:0] bitrate_index;
        reg [1:0] sample_rate_index;
        reg padding_bit, private_bit;
        reg [1:0] channel_mode, mode_extension;
        reg       copyright_bit, original_bit;
        reg [1:0] emphasis;

	wire [31:0] mp3_header;

	
	mp3_header_generator uut (
	mpeg_version, layer, protection_bit,
        bitrate_index, sample_rate_index, 
        padding_bit, private_bit, 
        channel_mode,mode_extension, 
        copyright_bit, original_bit, emphasis,
	mp3_header
    );

     initial begin

	mpeg_version = 2'b11;
        layer = 2'b01;
        protection_bit = 1'b1;
        bitrate_index = 4'b1001;
        sample_rate_index = 2'b00;
        padding_bit = 0;
        private_bit = 0;
        channel_mode = 2'b01;
        mode_extension = 0;
        copyright_bit = 0;
        original_bit = 1;
        emphasis = 0;

	#10;
	
	$display("MP3 Header = %h", mp3_header);
	#10 $finish;
    end

  initial begin
	$dumpfile("mp3_header.vcd");
	$dumpvars(0, tb_mp3_header_generator);
    end	

endmodule
