module pcm_output(input clk,input reset,input data_valid,input signed [15:0] sample_in,output reg signed [15:0] pcm_out,output reg pcm_valid);
always @(posedge clk or posedge reset) begin
	if (reset) begin
		pcm_out<=16'sd0;
		pcm_valid<=1'b0;
	end
	else begin
		pcm_valid<=1'b0;
		if(data_valid) begin
			pcm_out<=sample_in;
			pcm_valid<=1'b1;
		end
	end
end
endmodule
