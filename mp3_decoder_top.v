`timescale 1ns/1ps
module mp3_decoder_top(input clk,input reset,input data_valid,input signed [3:0] huff_x,input signed [3:0] huff_y,output signed [15:0] pcm_out,output pcm_valid);
wire signed [15:0] dequant_x;
wire signed [15:0] dequant_y;
wire dequant_valid;
wire signed [15:0] imdct_out;
wire imdct_valid;
dequantizer u_dequantizer(.clk(clk), .reset(reset), .data_valid(data_valid), .x_in(huff_x), .y_in(huff_y), .x_out(dequant_x), .y_out(dequant_y), .output_valid(dequant_valid));
imdct u_imdct(.clk(clk), .reset(reset), .data_valid(dequant_valid), .x_in(dequant_x), .y_in(dequant_y), .pcm_out(imdct_out), .output_valid(imdct_valid));
pcm_output u_pcm_output(.clk(clk), .reset(reset), .data_valid(imdct_valid), .pcm_out(pcm_out), .pcm_valid(pcm_valid));
endmodule
