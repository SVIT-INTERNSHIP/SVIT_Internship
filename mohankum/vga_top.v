module vga_top (
	input wire clk,
	input wire reset,
	output wire hsync,
	output wire v_sync,
	output wire [3:0] red,
	output wire [3:0] green,
	output wire [3:0] blue);
reg [9:0] x;
wire [9:0] v_count;
wire h_sync_tick;
wire v_active;
assign h_sync_tick = (x == 10'd799);
always @(posedge clk or posedge reset)
begin
	if (reset)
		x <= 10'd0;
	else if (x == 10'd799)
		x <= 10'd0;
	else 
		x <= x + 1'b1;
end
hsync_vga u_hsync (
	.clk(clk),
	.reset(reset),
	.hsync(hsync)
);

vga_vsync u_vsync (
	.clk(clk),
	.reset(reset),
	.h_sync_tick(h_sync_tick),
	.v_sync(v_sync),
	.v_count(v_count),
	.v_active(v_active)
);
rgb u_rgb (
	.x(x),
	.y(v_count),
	.red(red),
	.green(green),
	.blue(blue)
);
endmodule
