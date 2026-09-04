`timescale 1ns/1ps
module side_info_parser(input clk,input reset,input data_valid,input data_bit,output reg side_info_valid,output reg [8:0] main_data_begin,output reg [2:0] private_bits,output reg [11:0] part2_3_length,output reg [8:0] big_values);
reg [5:0] bit_count;
reg [1:0] state;
localparam IDLE=2'b00;
localparam READ=2'b01;
localparam DONE=2'b10;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		bit_count<=6'd0;
		state<=IDLE;
		side_info_valid<=1'b0;
		main_data_begin<=9'd0;
		private_bits<=3'd0;
		part2_3_length<=12'd0;
		big_values<=9'd0;
	end
	else begin
		side_info_valid<=1'b0;
		if(data_valid) begin
			case(state)
				IDLE: begin
					bit_count<=6'd0;
					state<=READ;
				end
				READ: begin
					if(bit_count<9)
						main_data_begin<={main_data_begin[7:0], data_bit};
					else if(bit_count<12)
						private_bits<={private_bits[1:0], data_bit};
					else if(bit_count<24)
						 part2_3_length<={part2_3_length[10:0], data_bit};
					else if(bit_count<33)
						big_values<={big_values[7:0], data_bit};
					if(bit_count==33) begin
						side_info_valid<=1'b1;
						state<=DONE;
						bit_count<=6'd0;
					end
					else begin
						bit_count<=bit_count+1'b1;
					end
					end
					DONE: begin 
						state<=IDLE;
					end
				endcase
		end
end
end
endmodule


