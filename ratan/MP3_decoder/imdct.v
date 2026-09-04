
module imdct(input clk,input reset,input data_valid,input signed [15:0] x_in,input signed [15:0] y_in,output reg signed [15:0] pcm_out,output reg output_valid);
reg [1:0] sample_count;
reg signed [31:0] temp_value;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		sample_count<=2'd0;
		temp_value<=32'sd0;
		pcm_out<=16'sd0;
		output_valid<=1'b0;
	end
	else begin
		output_valid<=1'b0;
		if (data_valid) begin
			case(sample_count)
				2'd0: begin
					temp_value=(237*x_in)+(98*y_in);
				end
				2'd1: begin
                                        temp_value=(98*x_in)-(237*y_in);
                                end

				2'd2: begin
                                        temp_value=(-98*x_in)+(237*y_in);
                                end

				2'd3: begin
                                        temp_value=(-237*x_in)-(98*y_in);
                                end
			endcase
			pcm_out<=temp_value>>>8;
			output_valid<=1'b1;
			if (sample_count==2'd3)
				sample_count<=2'd0;
			else
				sample_count<=sample_count+1'b1;
			end
		end
	end
endmodule


