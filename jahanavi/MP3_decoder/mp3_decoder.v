`timescale 1ns/1ps
module mp3_decoder(
input clk,
input reset,
input data_valid,
input data_bit,
input side_info_start,
input [255:0] side_info,
input ancillary_start,
input ancillary_data_valid,
input[7:0] ancillary_data_in,

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
output [1:0] emphasis,

output side_info_done,
output side_info_error,
output [8:0] main_data_begin,

output [7:0] ancillary_data,
output ancillary_valid,
output ancillary_last,

output signed [15:0] pcm_out,
output pcm_valid
);

wire frame_start;
wire header_valid;
wire frame_main_data_valid;
wire frame_done;

wire [31:0] header_data;
wire [15:0] frame_main_data;

mp3_frame_parser u_frame_parser(
.clk(clk),
.reset(reset),
.data_valid(data_valid),
.data_bit(data_bit),
.frame_start(frame_start),
.header_valid(header_valid),
.main_data_valid(frame_main_data_valid),
.frame_done(frame_done),
.header_data(header_data),
.main_data(frame_main_data)
);

mp3_header_decoder u_header_decoder(
.header(header_data),
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

wire [2:0] side_private_bits;
wire [7:0] scfsi;
wire [11:0] part23_0;
wire [11:0] part23_1;
wire [11:0] part23_2;
wire [11:0] part23_3;

wire [8:0] big_0;
wire [8:0] big_1;
wire [8:0] big_2;
wire [8:0] big_3;

wire [7:0] gain_0;
wire [7:0] gain_1;
wire [7:0] gain_2;
wire [7:0] gain_3;

wire win_0;
wire win_1;
wire win_2;
wire win_3;

mp3_sideinfo u_sideinfo(
.clk(clk),
.reset(reset),
.start(side_info_start),
.header(header_data),
.side_info(side_info),
.done(side_info_done),
.error(side_info_error),
.main_data_begin(main_data_begin),
.private_bits(side_private_bits),
.scfsi(scfsi),
.part23_0(part23_0),
.part23_1(part23_1),
.part23_2(part23_2),
.part23_3(part23_3),
.big_0(big_0),
.big_1(big_1),
.big_2(big_2),
.big_3(big_2),
.gain_0(gain_0),
.gain_1(gain_1),
.gain_2(gain_2),
.gain_3(gain_3),
.win_0(win_0),
.win_1(win_1),
.win_2(win_2),
.win_3(win_3)
);

reg [15:0] main_data_reg;
reg [4:0] main_bit_count;
reg main_bit_valid;
reg main_bit;

always@(posedge clk or posedge reset)begin
if (reset)begin
main_data_reg <= 16'd0;
main_bit_count <= 5'd0;
main_bit_valid <= 1'b0;
main_bit <= 1'b0;
end
else begin

main_bit_valid <= 1'b0;

if (frame_main_data_valid) begin
main_data_reg <= frame_main_data;
main_bit_count <= 5'd1;
main_bit <= frame_main_data[15];
main_bit_valid <= 1'b1;
end

else if (main_bit_valid && main_bit_count < 5'd16) begin
main_bit <= main_data_reg[15-main_bit_count];
main_bit_count <= main_bit_count + 1'b1;
main_bit_valid <= 1'b1;
end
end
end

wire huffman_valid;
wire signed [3:0] huff_x;
wire signed [3:0] huff_y;

huffman_decoder u_huffman(
.clk(clk),
.reset(reset),
.data_valid(main_bit_valid),
.data_bit(main_bit),
.decode_valid(huffman_valid),
.x(huff_x),
.y(huff_y)
);

wire signed[15:0] dequant_x;
wire signed[15:0] dequant_y;
wire dequant_valid;

dequantizer u_dequantizer(
.clk(clk),
.reset(reset),
.data_valid(huffman_valid),
.x_in(huff_x),
.y_in(huff_y),
.x_out(dequant_x),
.y_out(dequant_y),
.output_valid(dequant_valid)
);

wire signed [15:0] imdct_out;
wire imdct_valid;

imdct u_imdct(
.clk(clk),
.reset(reset),
.data_valid(dequant_valid),
.x_in(dequant_x),
.y_in(dequant_y),
.pcm_out(imdct_out),
.output_valid(imdct_valid)
);

pcm_output u_pcm_output(
.clk(clk),
.reset(reset),
.data_valid(imdct_valid),
.sample_in(imdct_out),
.pcm_out(pcm_out),
.pcm_valid(pcm_valid)
);

mp3_ancillary_decoder u_ancillary_decoder(
.clk(cllk),
.reset(reset),
.start_frame(ancillary_start),
.data_valid(ancillary_data_valid),
.data_in(ancillary_data_in),
.ancillary_data(ancillary_data),
.ancillary_valid(ancillary_valid),
.ancillary_last(ancillary_last)
);

endmodule

