module hsync_vga(
	input wire clk,
	input wire reset,
	output reg hsync);
reg [9:0]h_count;
always @(posedge clk or posedge reset)
begin
if(reset)
begin
	h_count<=10'd0;
	hsync<=1'b1;
end
else
begin
if(h_count==10'd799)
	h_count<=10'd0;
else
h_count<=h_count+1'b1;

if((h_count>=10'd656)&&(h_count<10'd752))
hsync<=1'b0;
else
hsync<=1'b1;
end
end
endmodule
