module rgb( 
	input  [9:0] x,
	input  [9:0] y,
	output reg [3:0] red,
	output reg [3:0] green,
	output reg [3:0] blue
);
always @(*) begin
	if (x < 213 ) begin
		red = 4'hF;
		green = 4'h0;
		blue = 4'h0;
	end
	else if (x<426) begin
		red = 4'h0;
		green = 4'hF;
		blue = 4'h0;
	end
	else if (x<640) begin
		red = 4'h0;
		green = 4'hF;
		blue = 4'hF;
	end
	else begin
		red = 4'h0;
		green = 4'h0;
		blue = 4'hF;
	end
end
endmodule
