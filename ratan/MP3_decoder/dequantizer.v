
module dequantizer(input clk,input reset,input data_valid,input signed [3:0] x_in,input signed [3:0] y_in,output reg signed [15:0] x_out,output reg signed [15:0] y_out,output reg output_valid);
always @(posedge clk or posedge reset) begin
	if (reset) begin
		x_out<=16'sd0;
		y_out<=16'sd0;
		output_valid<=1'b0;
	end
	else begin
		output_valid<=1'b0;
		if(data_valid) begin
			if (x_in<0)
				x_out<=-(x_in*x_in);
			else
				x_out<=x_in*x_in;
			if (y_in<0)
				y_out<=-(y_in*y_in);
			else
				y_out<=y_in*y_in;
			output_valid<=1'b1;
		end
	end
end
endmodule
