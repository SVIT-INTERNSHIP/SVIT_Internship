module mp3_header_generator (
input wire      clk,
input wire      rst_n,
input wire      enable,



input wire [1:0] mpeg_version,
input wire [1:0] layer,
input wire protection_not_set,
input wire [3:0] bitrate_index,
input wire [1:0] sampling_freq,
input wire       padding_bit,
input wire       private_bit,
input wire [1:0] channel_mode,
input wire [1:0] mode_extension,
input wire       copyright,
input wire       original,
input wire [1:0] emphasis,
output reg [31:0] header_out,
output reg        valid_out
);
localparam [10:0] SYNC_WORD =11'b1111_1111_111;

always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
header_out <= 32'h0000_0000;
valid_out <= 1'b0;
end else if (enable) begin
header_out <= {
  
SYNC_WORD,
mpeg_version,
layer,
protection_not_set,
bitrate_index,
sampling_freq,
padding_bit,
private_bit,
channel_mode,
mode_extension,
copyright,
original,
emphasis
};
valid_out <= 1'b1;
end else begin
valid_out <= 1'b0;
end
end
endmodule

