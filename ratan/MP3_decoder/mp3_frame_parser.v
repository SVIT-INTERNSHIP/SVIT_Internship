`timescale 1ns/1ps
module mp3_frame_parser(input clk,input reset,input data_valid,input data_bit,output reg frame_start,output reg header_valid,output reg main_data_valid,output reg frame_done,output reg [31:0] header_data,output reg [15:0] main_data);
localparam IDLE=2'b00;
localparam HEADER=2'b01;
localparam MAIN_DATA=2'b10;
reg [1:0] state;
reg [7:0] sync_reg;
reg [5:0] bit_count;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state<=IDLE;
		sync_reg<=8'b0;
		bit_count<=6'd0;
		frame_start<=1'b0;
		header_valid<=1'b0;
		main_data_valid<=1'b0;
		frame_done<=1'b0;
		header_data<=32'b0;
		main_data<=16'b0;
	end
	else begin
		frame_start<=1'b0;
		header_valid<=1'b0;
		main_data_valid<=1'b0;
		frame_done<=1'b0;
		if (data_valid) begin
			case(state)
				IDLE: begin
					sync_reg<={sync_reg[6:0],data_bit};
					if({sync_reg[6:0],data_bit}==8'b11111111) begin
						frame_start<=1'b1;
						bit_count<=6'd0;
						header_data<=32'd0;
						state<=HEADER;
					end
				end
				HEADER: begin
					header_data <= {header_data[30:0],data_bit};
					if (bit_count == 6'd31) begin
						header_valid<=1'b1;
						bit_count<=6'd0;
						main_data<=16'd0;
						state<=MAIN_DATA;
					end
					else begin
						bit_count<=bit_count+1'b1;
					end
				end
				MAIN_DATA: begin
					main_data<={main_data[14:0],data_bit};
					if (bit_count==6'd15) begin
						main_data_valid<=1'b1;
						frame_done<=1'b1;
						bit_count<=6'd0;
						state<=IDLE;
					end
					else begin
						bit_count<=bit_count+1'b1;
					end
				end
				default: begin
					state<=IDLE;
				end
			endcase
		end
	end
end
endmodule
