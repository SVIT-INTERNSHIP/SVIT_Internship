module fifo(
input clk,
input reset,
input write_en,
input read_en,
input [7:0] data_in,
output reg [7:0] data_out,
output empty,
output full
);

reg [7:0] memory [0:7];
reg [2:0] write_ptr;
reg [2:0] read_ptr;
reg [3:0] count;

assign empty = (count == 4'd0);
assign full = (count == 4'd8);

always @(posedge clk) begin
if (reset) begin
write_ptr <= 3'd0;
read_ptr <= 3'd0;
count <= 4'd0;
data_out <= 8'd0;
end

else begin
if (write_en && !full) begin
memory[write_ptr] <= data_in;
write_ptr <= write_ptr +  1'b1;
end

if (read_en && !empty) begin
data_out <= memory[read_ptr];
read_ptr <= read_ptr + 1'b1;
end

if (write_en && !full && !(read_en && !empty)) begin
count <= count + 1'b1;
end

else if (read_en && !empty && !(write_en && !full)) begin
count <= count - 1'b1;
end
end
end
endmodule
