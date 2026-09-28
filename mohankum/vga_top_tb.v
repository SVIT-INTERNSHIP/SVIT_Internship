
module vga_top_tb;

reg clk;
reg reset;
wire hsync;
wire v_sync;
wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;
reg [11:0] frame_buffer [0:419999];
integer i;
integer dot_x;
integer dot_y;
integer pixel_address;

vga_top uut (
	.clk(clk),
	.reset(reset),
	.hsync(hsync),
	.v_sync(v_sync),
	.red(red),
	.green(green),
	.blue(blue)
);
always #5 clk = ~clk;
initial begin
	clk = 1'b0;
	reset = 1'b1;
	#20; 
	reset = 1'b0;
	#1000000;
	$finish;
end
initial begin
	for (i =0; i<420000; i=i+1)
	begin
		frame_buffer[i] = 12'h000;
	end
	dot_x = 100;
	dot_y = 100;
	pixel_address = (dot_y * 800)+dot_x;
	frame_buffer[pixel_address] = 12'hF00;
end
always @(posedge clk) begin
	if ((uut.x == dot_x) && (uut.v_count == dot_y)) begin
	$display("================");
	$display("ONE PIXEL CHECK");
	$display("================");
	$display("X coordinate = %d", uut.x);
	$display("Y coordinate = %d", uut.v_count);
	$display("Pixel address = %d",pixel_address);	
	$display("Frame buffer RGB= %h", frame_buffer[pixel_address]);	
	$display("Expected RED= %h", frame_buffer[pixel_address][11:8]);	
	$display("Expected GREEN= %h", frame_buffer[pixel_address][7:4]);	
	$display("Expected BLUE= %h", frame_buffer[pixel_address][3:0]);
	$display("Actual RED =%h",red);	
	$display("Actual GREEN =%h",green);	
	$display("Actual BLUE =%h",blue);
	$display("HSYNC = %b",hsync);	
	$display("VSYNC = %b",v_sync);
	$display("=================");
	end
end
initial begin	
	$dumpfile("vga_top_tb.vcd");
	$dumpvars(0, vga_top_tb);
end
endmodule
