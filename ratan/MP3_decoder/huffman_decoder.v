`timescale 1ns/1ps
module huffman_decoder(input clk,input reset,input data_valid,input data_bit,output reg decode_valid,output reg signed [3:0] x,output reg signed [3:0] y);
reg [3:0] code;
reg [2:0] bit_count;
always @(posedge clk or posedge reset) begin
	if (reset) begin
code<=4'b0000;
bit_count<=3'd0;
decode_valid<=1'b0;
x<=4'sd0;
y<=4'sd0;
end
else begin
	decode_valid<=1'b0;
	if(data_valid) begin
		code<={code[2:0], data_bit};
	if(bit_count==3) begin
		case({code[2:0], data_bit})
		4'b0000: begin
			x<=4'sd0;
			y<=4'sd0;
		end
		 4'b0001: begin
                        x<=4'sd0; 
                        y<=4'sd1;
		end
		 4'b0010: begin
                        x<=4'sd1; 
                        y<=4'sd0;
		end
		 4'b0011: begin
                        x<=4'sd1; 
                        y<=4'sd1;
		end
		 4'b0100: begin
                        x<=4'sd1; 
                        y<=4'sd0;
		end
		 4'b0101: begin
                        x<=4'sd0; 
                        y<=4'sd1;
		end
		 default: begin
                        x<=4'sd0; 
                        y<=4'sd0;
		end
		endcase
		decode_valid<=1'b1;
		bit_count<=3'd0;
		code<=4'b0000;
		end
		else begin
			bit_count<=bit_count+1'b1;
		end
	end
end
end
endmodule
