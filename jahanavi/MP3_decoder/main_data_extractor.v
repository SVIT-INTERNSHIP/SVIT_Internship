`timescale 1ns/1ps
module main_data_extractor(input clk,input reset,input data_valid,input data_bit,input [8:0] main_data_begin,output reg main_data_valid,output reg [31:0] main_data);
reg [5:0] bit_count;
always @(posedge clk or posedge reset) begin
if (reset) begin
	bit_count<=6'd0;
	main_data<=32'd0;
	main_data_valid<=1'b0;
end
else begin
	main_data_valid<=1'b0;
	if (data_valid) begin
		main_data<={main_data[30:0], data_bit};
		if (bit_count==6'd31) begin
			main_data_valid<=1'b1;
			bit_count<=6'd0;
		end
		else begin
			bit_count<=bit_count+1'b1;
		end
	end
end
end
endmodule
